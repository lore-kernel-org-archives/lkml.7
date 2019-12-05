Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BTC_ID,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40D8C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873CB2464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igud6vN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfLENrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:47:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27174 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729187AbfLENrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575553621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LvnCHUl5lhFek9Nf47pDiu/dj5YoIgTQQRyypsYUfdk=;
        b=igud6vN1B0AUFT7oEK3sHPIpyc0Lqi0/AYS4HzIvXQuAS3YAZGMNMPzLzp8W9WK6gkvnMh
        tlpopXgEb1+J/3b1pLyOjVhjZrjFkds4GZVUyxGGpkr7lJOIoKCh8GDmgAjb/xzvO6mdfd
        mOyIELOAKssMKqoy/75wODuC32M4mtU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-TQmWTNCmMG6DcItQWk2nFw-1; Thu, 05 Dec 2019 08:46:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC095800599;
        Thu,  5 Dec 2019 13:46:54 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF1A95DA75;
        Thu,  5 Dec 2019 13:46:52 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     andrea.parri@amarulasolutions.com, brendanhiggins@google.com,
        gregkh@linuxfoundation.org, john.ogness@linutronix.de,
        kexec@lists.infradead.org, peterz@infradead.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        sergey.senozhatsky.work@gmail.com, tglx@linutronix.de,
        torvalds@linux-foundation.org
Subject: Re: [RFC PATCH v5 0/3] printk: new ringbuffer implementation
Date:   Thu,  5 Dec 2019 08:46:52 -0500
Message-Id: <20191205134652.12631-1-prarit@redhat.com>
In-Reply-To: <20191128015235.12940-1-john.ogness@linutronix.de>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: TQmWTNCmMG6DcItQWk2nFw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  John Ogness <john.ogness@linutronix.de> wrote:
> Hello,
>=20
> This is a follow-up RFC on the work to re-implement much of the
> core of printk. The threads for the previous RFC versions are
> here[0][1][2][3].
>=20
> This RFC includes only the ringbuffer and a test module. This is
> a rewrite of the proposed ringbuffer, now based on the proof of
> concept[4] from Petr Mladek as agreed at the meeting[5] during
> LPC2019 in Lisbon.
>=20
> The internal structure has been reworked such that the printk
> strings are in their own array, each separated by a 32-bit
> integer.
>=20
> A 2nd array contains the dictionary strings (also with each
> separated by a 32-bit integer).
>=20
> A 3rd array is made up of descriptors that contain all the
> meta-data for each printk record (sequence number, timestamp,
> loglevel, caller, etc.) as well as pointers into the other data
> arrays for the text and dictionary data.
>=20
> The writer interface is somewhat similar to v4, but the reader
> interface has changed significantly. Rather than using an
> iterator object, readers just specify the sequence number they
> want to read. In effect, the sequence number acts as the
> iterator.
>=20
> I have been communicating with Petr the last couple months to
> make sure this implementation fits his expectations. This RFC is
> mainly to get some feedback from anyone else that may see
> something that Petr and I have missed.
>=20
> This series also includes my test module. On a 16-core ARM64
> test machine, the module runs without any errors. I am seeing
> the 15 writing cores each writing about 34500 records per
> second, while the 1 reading core misses only about 15% of the
> total records.
>=20

John,

Based on the comments there is going to be a v6 but in any case I am
starting testing of this patchset on several large core systems across
multiple architectures (x86_64, ARM64, s390, ppc64le).  Some of those
systems are known to fail boot due to the large amount of printk output so
it will be good to see if these changes resolve those issues.

Sorry for the delay and I'll report back in a few days.

P.

> John Ogness
>=20
> [0] https://lkml.kernel.org/r/20190212143003.48446-1-john.ogness@linutron=
ix.de
> [1] https://lkml.kernel.org/r/20190607162349.18199-1-john.ogness@linutron=
ix.de
> [2] https://lkml.kernel.org/r/20190727013333.11260-1-john.ogness@linutron=
ix.de
> [3] https://lkml.kernel.org/r/20190807222634.1723-1-john.ogness@linutroni=
x.de
> [4] https://lkml.kernel.org/r/20190704103321.10022-1-pmladek@suse.com
> [5] https://lkml.kernel.org/r/87k1acz5rx.fsf@linutronix.de
>=20
> John Ogness (3):
>   printk-rb: new printk ringbuffer implementation (writer)
>   printk-rb: new printk ringbuffer implementation (reader)
>   printk-rb: add test module
>=20
>  kernel/printk/Makefile            |   3 +
>  kernel/printk/printk_ringbuffer.c | 910 ++++++++++++++++++++++++++++++
>  kernel/printk/printk_ringbuffer.h | 249 ++++++++
>  kernel/printk/test_prb.c          | 347 ++++++++++++
>  4 files changed, 1509 insertions(+)
>  create mode 100644 kernel/printk/printk_ringbuffer.c
>  create mode 100644 kernel/printk/printk_ringbuffer.h
>  create mode 100644 kernel/printk/test_prb.c
>=20
> --=20
> 2.20.1

