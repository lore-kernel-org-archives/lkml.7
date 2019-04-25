Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD00C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A96D20811
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbfDYLi1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:38:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfDYLi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:38:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4EF7B306D323;
        Thu, 25 Apr 2019 11:38:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B6F61001E87;
        Thu, 25 Apr 2019 11:38:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAG48ez23c1eiEJpBwkV183sesj6EDWoMsEh40GDXQkS1W2_nMA@mail.gmail.com>
References: <CAG48ez23c1eiEJpBwkV183sesj6EDWoMsEh40GDXQkS1W2_nMA@mail.gmail.com> <155612240208.8564.13865046977065545591.stgit@warthog.procyon.org.uk> <155612246750.8564.9186344007442012471.stgit@warthog.procyon.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     dhowells@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>, dwalsh@redhat.com,
        vgoyal@redhat.com
Subject: Re: [PATCH 07/11] keys: Move the user and user-session keyrings to the user_namespace
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3831.1556192301.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Thu, 25 Apr 2019 12:38:21 +0100
Message-ID: <3832.1556192301@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 25 Apr 2019 11:38:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn <jannh@google.com> wrote:

> > +       struct key              *user_keyring_register;
> 
> Maybe a comment about locking semantics above user_keyring_register?
> "Only written once, may be read locklessly with READ_ONCE()", or
> something like that?

Ok.

> > -
> > +#define __KDEBUG
> 
> Was that supposed to be in here, or did you commit that accidentally?

Accidental.

> > -       struct key *uid_keyring, *session_keyring;
> > +       struct key *reg_keyring = user_ns->user_keyring_register;
> 
> This is a lockless read of a field that may be written concurrently;
> this should be READ_ONCE(). (Especially on alpha, I think the memory
> ordering will actually be incorrect without READ_ONCE().)

Yeah, you're right about both of these that you pointed out.  It's not needed
when the user_ns->keyring_sem is taken for writing, however.

> > +               if (!IS_ERR(reg_keyring))
> > +                       user_ns->user_keyring_register = reg_keyring;
> 
> This is a write of a pointer that may be read concurrently; this
> should be smp_store_release().

Yep.

> > +       else if ((user_session = get_user_session_keyring())) {
> > +               key_ref = keyring_search_aux(make_key_ref(user_session, 1),
> > +                                            ctx);
> >                 if (!IS_ERR(key_ref))
> >                         goto found;
> 
> I'm not sure I understand this code. In the "goto found" case, the
> key_put() below is skipped, right? Is that intentional?

Actually, the key_put() should be directly after the keyring_search_aux()
call, before the error check.

> >  error_alloc:
> >         complete_request_key(authkey, ret);
> > +error_us:
> > +       key_put(user_session);
> >         kleave(" = %d", ret);
> >         return ret;
> >  }
> 
> This looks weird. If the look_up_user_keyrings() fails, user_session
> might still be an uninitialized pointer, right? And then the "goto
> error_us" jumps down here and calls key_put() on that?

The call to complete_request_key() should be after error_us and the key_put()
should be before it.

> > @@ -289,16 +291,19 @@ static int construct_get_dest_keyring(struct key **_dest_keyring)
> >
> >                         if (dest_keyring)
> >                                 break;
> > +                       /* Fall through */
> >
> >                         /* fall through */
> >                 case KEY_REQKEY_DEFL_USER_SESSION_KEYRING:
> 
> Why two "fall through" comments?

Someone else added one and when I rebased, I don't think I got a conflict.

David
