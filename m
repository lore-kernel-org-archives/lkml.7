Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520ADCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195F320640
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHcdZDYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbfJUOWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:22:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42300 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727555AbfJUOWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571667728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=juvjyDj/bXESr8Pj+8TGvYoxpIfnIpsm8+f+H/8UCWM=;
        b=AHcdZDYlTAh1iWhTBQfQix00XLQu6ecluEQNbfPUrlTsVswhQbSKH5iLrIQhL/9QNiE6wz
        GhZCoOtjDVvbg7MsjcdWWnfiMR1wu/GrKBfPOc3zi4HceHGXWG3k2Fly+wQxVaayKj6iuz
        q11INVBLyZvgYgUXLpt97J1NIIHA6is=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-C06jtCk6MO2DbhBQzqUQyw-1; Mon, 21 Oct 2019 10:22:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFB4947B;
        Mon, 21 Oct 2019 14:22:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39B1E5D717;
        Mon, 21 Oct 2019 14:22:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20191018184030.8407-1-crecklin@redhat.com>
References: <20191018184030.8407-1-crecklin@redhat.com>
To:     Chris von Recklinghausen <crecklin@redhat.com>
Cc:     dhowells@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] security/keyring: avoid pagefaults in keyring_read_iterator
MIME-Version: 1.0
Content-ID: <30308.1571667719.1@warthog.procyon.org.uk>
Date:   Mon, 21 Oct 2019 15:21:59 +0100
Message-ID: <30309.1571667719@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: C06jtCk6MO2DbhBQzqUQyw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris von Recklinghausen <crecklin@redhat.com> wrote:

> The put_user call from keyring_read_iterator caused a page fault which
> attempts to lock mm->mmap_sem and type->lock_class (key->sem) in the reve=
rse
> order that keyring_read_iterator did, thus causing the circular locking
> dependency.
>=20
> Remedy this by using access_ok and __put_user instead of put_user so we'l=
l
> return an error instead of faulting in the page.

I wonder if it's better to create a kernel buffer outside of the lock in
keyctl_read_key().  Hmmm...  The reason I didn't want to do that is that
keyrings have don't have limits on the size.  Maybe that's not actually a
problem, since 1MiB would be able to hold a list of a quarter of a million
keys.

David

