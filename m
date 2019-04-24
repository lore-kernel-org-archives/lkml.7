Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35750C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E6320835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbfDXWYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:24:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfDXWYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:24:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EACDB308A124;
        Wed, 24 Apr 2019 22:24:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39EB45DEFE;
        Wed, 24 Apr 2019 22:24:32 +0000 (UTC)
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
Content-ID: <3752.1556144671.1@warthog.procyon.org.uk>
Date:   Wed, 24 Apr 2019 23:24:31 +0100
Message-ID: <3753.1556144671@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 24 Apr 2019 22:24:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn <jannh@google.com> wrote:

> Overall, this looks good to me, apart from some details.
> 
> The user_keyring_register keyring is basically just used like an
> xarray/idr/... that maps from namespaced UIDs to keyrings, right? (Not
> saying it's a bad idea, just want to make sure I understand it
> correctly.)

Well, a keyring is a wrapper around an assoc_array object, the keyring search
functions do the access checks and the keys garbage collector does the
cleanup.  Also, each UID is mapped to two keyrings.

I'll have a look at applying the rest of your comments tomorrow.

Thanks,
David
