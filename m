Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD6DCA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7292206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572098144;
	bh=oS8AafU4UoR1Cdt5q1QkipV0ZVxN87r+AIY8DNgHUts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YSPG10ZADHSo+PSAbEXHn6ENkICuiSmzq6Fl/MGfHiihc/NZynkTURe16F1yXFoZL
	 qHvDbclWaCI2X/EkbdTlpBAv+dDXqp5MlP3Pq3Ochg1ubEGifJVa1FC0EHd9oVld8Q
	 IMT1+BrUd0aGRGS2k2YSbgV6fTvYHp9HN+oeC5fM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfJZNzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:55:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbfJZNzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:55:41 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF8A621897
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572098141;
        bh=oS8AafU4UoR1Cdt5q1QkipV0ZVxN87r+AIY8DNgHUts=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UdKa/EIasgUwWUWKLVUZjsocCCXKaIIKQvHCKkWsta4ac76dgl2yQ/T8MABrC3sI7
         QT4WVsaHMploW8g3OvhBvq4nUFVqX2zrXBy68w8n3je7YCvffgOqbOQqcXWLA2hKIV
         C5TuFXmNCXo9w+NkE8kU8xCo3ymWDEd1iMs2nCNo=
Received: by mail-wr1-f53.google.com with SMTP id q13so5310888wrs.12
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 06:55:40 -0700 (PDT)
X-Gm-Message-State: APjAAAWhrBEXCMSFNbWiIKiWXrGk+FVTpaBjiPCAUStMrxG9DQcS3MQM
        epN1Z2cMBNwZSp9ebYLeqfLGApXKxRJoRENgfBrsBA==
X-Google-Smtp-Source: APXvYqwvksRrIQEjjgyaaAImviBGypA0F9sRduelJfzhcIHS0Kqw9RdPhWtrIf2y553xqjuua9wmwExmrcJ/9/9X9zs=
X-Received: by 2002:adf:f04e:: with SMTP id t14mr7762143wro.106.1572098139231;
 Sat, 26 Oct 2019 06:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <8ce3582f7f7da9ff0286ced857e5aa2e5ae6746e.1571662378.git.christophe.leroy@c-s.fr>
 <alpine.DEB.2.21.1910212312520.2078@nanos.tec.linutronix.de>
 <f4486e86-3c0c-0eec-1639-0e5956cdb8f1@c-s.fr> <95bd2367-8edc-29db-faa3-7729661e05f2@c-s.fr>
In-Reply-To: <95bd2367-8edc-29db-faa3-7729661e05f2@c-s.fr>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 26 Oct 2019 06:55:28 -0700
X-Gmail-Original-Message-ID: <CALCETrWEKrE6nhu2F9+V_8EhWKqyuq5Qit05Uj9V_TeBKZNJsw@mail.gmail.com>
Message-ID: <CALCETrWEKrE6nhu2F9+V_8EhWKqyuq5Qit05Uj9V_TeBKZNJsw@mail.gmail.com>
Subject: Re: [RFC PATCH] powerpc/32: Switch VDSO to C implementation.
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 6:56 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
> >>> The performance is rather disappoiting. That's most likely all
> >>> calculation in the C implementation are based on 64 bits math and
> >>> converted to 32 bits at the very end. I guess C implementation should
> >>> use 32 bits math like the assembly VDSO does as of today.
> >>
> >>> gettimeofday:    vdso: 750 nsec/call
> >>>
> >>> gettimeofday:    vdso: 1533 nsec/call
> >
> > Small improvement (3%) with the proposed change:
> >
> > gettimeofday:    vdso: 1485 nsec/call
>
> By inlining do_hres() I get the following:
>
> gettimeofday:    vdso: 1072 nsec/call
>

A perf report might be informative.
