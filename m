Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EA5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 05:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E5F21655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 05:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="jm3cX1F0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437568AbfJXFlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 01:41:31 -0400
Received: from sonic315-8.consmr.mail.gq1.yahoo.com ([98.137.65.32]:36089 "EHLO
        sonic315-8.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406827AbfJXFlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 01:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1571895689; bh=5GQIr7IaB9RS8gJWjgXdB8tkau2TC16X6XzdFwNy+0E=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=jm3cX1F0hc5Qml2Eo44Ez0Yv29dHn2TRDUz/y7KNAACNYyppbcyujYjk3xIR9ZCp5LjBBu6jEudMee+PMFJiu4FteQo/f1XYVE238l75Q8EtW9BR28PuyTu1OTBAz1RqOyTPPGSQB7dBzm1kQ65cQQu2/iLtYNdaqpGQsGNVlqXx/tXmwn3/ShAoYPtodo4LWEZF2PkZGgEomBDC2sgQSiQHsyAPD8yp+9wWsEfrZI0fCzkftH8ZgijMiOqxB3X9mu4HNUZ+8muCWFw1hiXylG1Wm1sFab9mT1mkJDI57B70m+U/EoZwbiRXIVLMhEuahN29H4vywKyZoDjRDc0eMg==
X-YMail-OSG: qDz6UgoVM1kExkeJ3_eGo6meNt8jjE1oBPJvNEOv24ds8CrF0wEfJLWdptO1q71
 FKDpLOOusTuXGgHuwRsG3JBFvce6zxKLxDb9sk6UPs5ux2f8stoHrTIV0ffI9YlFAbLk8s3QvExp
 ci6reBga0vsOsSYllpAQIenqJzi58dd9Xf_kdPUrL1D3xGmBa6CK5ZQUZzJ_dfZza0sZ7KOGFbAo
 IOaEN3tnOAbI4GDl2sOgRdXZgpasITyXenAYXCJR0eIWqNBE_iarximrfT_sYvp0ovnFbDcdX71n
 agmsO42vF86d.jDrCvLVvcsu6Hs3MiIvwn83pdnRqCsFp4vVPOCi.QxFaB5baGuFZ_.7nZJTWGEu
 0Mr64k.V3XQphIm0hXQcYLxOAVvkkyEw7mq0ICpYWb3mb4dI3h0.0YJgymOuCe7EzsDf8B_VkN_0
 li6XJG0orebZx.YHoqtOdSxfGuqfFdCNBzGG5JalGFvoMIuZmWDwiBMOEJ1zqA5wWlCkMjS5IL2H
 be1uX8K1HUrgwUD.hbDfWeY2yxpB.jeeOXR.vPwmtj0ONvAep6lcV9UoGwxU_.8Ip3Q5dWJDuAHw
 9.Yx.825bJ6fWArm_pkB.F0xZoWTXZFATjuscZwLk7yzskDSIqIBBzHDVTocGNnKZI1njj4NDFc3
 8.lEPEoG.Hy5kwjYCgYG2e87cWisbpS26GKJnVxrqi3_17NAY4Bkh5zDNzEpvvxbohHZ.HeiAP0P
 IshxkZAbKMBcaJ9wREYtGHRzQ9HdGP2CK4YTJVvM9DhtGHgMGIn9dLACw57dBUX1aQINi.TMTM1D
 JdV83TQQ6_lrZdpBM1SXdSzC17sEcNNAWxvVCQKXdiZbr7e6JwwcIS1QQXEAX8eZGLFogHm3fwdh
 l4FdX3UE0k7GDl5eouJ.uXP8j17g7OaWyOn_Sr38YA0JAZzgHbirLjPU6amZ06LbfSeI3yxU7RlB
 mwkaJ_40CXTi4CPNS0TOKImGGACtQCH31mlZqI1C4zeiLPZFANNO52bJEUhTAH04uGO1z2mMzsL6
 3aDPzP_cbly2_CRWjXZ4K_8higo5YDs3BXQlwit9Mp2AvHxpLQHqzx_6GxcSF_ppKrABm6H4xOvo
 e.Ko218thoKcLivXkuAYkgXvSbBUKKXtYokNyEfxKN6PhfhcksqJs9_1a_j4ST_SW8XPatmiMXvw
 r_rVQ9MzoQD2.k6vKeZvKTuU5CQNHrBjq_RBBCc6phAz8AGNCX8FOBonR1Rzvs2UUOXJTszWFOSJ
 vm_l.uOSrbPug_DIVLL1XBN1SUjiffDzfWpv0VgdVgQHGu2M3DCtvsPK_Z1AOyrWb8hXyMd1VEXH
 7YyCWsuaH9dOhTNhHuf_weBbxX2lVS17BQiSZb9Z6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 24 Oct 2019 05:41:29 +0000
Received: by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 58468a67fe640e75d17c6286566093fa;
          Thu, 24 Oct 2019 05:41:25 +0000 (UTC)
Date:   Thu, 24 Oct 2019 13:41:15 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Philippe Liard <pliard@google.com>
Cc:     phillip@squashfs.org.uk, linux-kernel@vger.kernel.org,
        groeck@chromium.org
Subject: Re: [PATCH] squashfs: Migrate from ll_rw_block usage to BIO
Message-ID: <20191024054112.GA1998@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191018010846.186484-1-pliard@google.com>
 <20191024012354.105261-1-pliard@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191024012354.105261-1-pliard@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 10:23:54AM +0900, Philippe Liard wrote:
> Thanks Cristoph for taking a look. I like the idea of simplifying this if
> possible. I think I understand your suggestion in principle but I'm not
> seeing a way to apply it here. Would it be possible for you to be a little
> more specific? Let me try to explain this below.
> 
> My admittedly?limited understanding is that using BIO indirectly requires
> buffer_head or an alternative including some synchronization mechanism at
> least.
> It's true that the bio_{alloc,add_page,submit}() functions don't require
> passing a buffer_head. However because bio_submit() is asynchronous AFAICT
> the client needs to use a synchronization mechanism to wait for and notify
> the completion of the request which buffer heads provide. This is achieved
> respectively by wait_on_buffer() and {set,clear}_buffer_uptodate().
> 
> Another dependency on buffer heads is the fact that squashfs_read_data()
> calls into other squashfs functions operating on buffer heads outside this
> file. For example squashfs_decompress() operates on a buffer_head array.
> 
> Given that bio_submit() is asynchronous I'm also not seeing how the
> squashfs_bio_request allocation can be removed? There can be multiple BIO
> requests in flight each needing to carry some context used on completion
> of the request.

Personally speaking, just for Android related use cases, I'd suggest latest
EROFS if you care more about system overall performance more than compression
ratio, even https://lkml.org/lkml/2017/9/22/814 is applied (you can do
benchmark), we did much efforts 3 years ago.

And that is not only performance but noticable memory overhead (a lot of
extra memory allocations) and heavy page cache thrashing in low memory
scenarios (it's very common [1].)

[1] https://linuxplumbersconf.org/event/4/contributions/404/attachments/326/550/Handling_memory_pressure_on_Android.pdf

Thanks,
Gao Xiang


