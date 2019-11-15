Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A79FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F52920723
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7E4azdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKOGrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 01:47:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37413 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfKOGrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:47:47 -0500
Received: by mail-wm1-f65.google.com with SMTP id b17so9086053wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 22:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=h6eijrK8cUxC8CXdJIBcySFLn2s6ouwc2eAMAO7Yyes=;
        b=F7E4azdR9jYdXe9IJM6V6g32ncVAFgLfs5WJQff5l0YFLEhwd00g0L91wRPaLhN8NA
         2RG4IL/h2dLth8xKeqwfuRWasWCOhr2Wq5N4rTq+RqWGo7Z2xTSx5/iRfK9jINGsgp5N
         V3irs7/8A/mQb1GvLKWE7NZT5ZPtL2T3dgfh6N+fm5wdw116AgoslDwixkp5Vtd+9DJv
         0QMpS77XlFxg6yxa/bfrp6iK518+NROIXwI62+w0s+hVu8rcW4cVQKTpx2svKLpXiXuE
         rdJ2PmHAao9o4wuuu9c+JzVvUnvwL8TiKxLGelI7TDtChfH7U1poW11maB2nzD1biEGQ
         8vLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=h6eijrK8cUxC8CXdJIBcySFLn2s6ouwc2eAMAO7Yyes=;
        b=e+8A7ZauV8WGdVCG9msuXQsxSTOxJfJjYDAYdsuHKC9rX0Je9jc4M5/A0B3TqpoY5U
         GL89yv7fE8IT56/5apBsUr/NZr9rph1lnjtOfPsshtVErfzve7UsUF67KNR2X2ws/NWu
         OH09H7XFFidOdcBaYJ8hZcKP3cWrckagffyQYakDqRj24f8hqUkmkBzYvP2jOFeGbCOX
         lxK8914C5wVUzRmHSob0WtNH0G7VoJUVkREXw9y+RDmF9MHRf1b84XIKdoTSsH/vlTnA
         p1xX4bQZ06U1whBfKgg9rGlbZLfCv207LQO2LoY+lBSsYoMShPT/YEA7JrramBZ+dOE7
         4F5A==
X-Gm-Message-State: APjAAAWi9cbZiUh/nSX/lRUmG7ys0HOWdqWlNaM+5T6XNZIn4Ldg/od3
        X62C3Z7mBTEWFRqglcOFz3zH1w==
X-Google-Smtp-Source: APXvYqwGXJtQkCBTsweQQRswiTBThypUGLrtgVwXGSWzzCLlpWA9L/kHnXqlVPEQ8MPJE01QlngFZg==
X-Received: by 2002:a05:600c:296:: with SMTP id 22mr12909062wmk.155.1573800465347;
        Thu, 14 Nov 2019 22:47:45 -0800 (PST)
Received: from [192.168.0.100] (84-33-69-45.dyn.eolo.it. [84.33.69.45])
        by smtp.gmail.com with ESMTPSA id f14sm9916446wrv.17.2019.11.14.22.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 22:47:44 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] block,bfq: Skip tracing hooks if possible
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20191101131110.18356-1-dmonakhov@gmail.com>
Date:   Fri, 15 Nov 2019 07:47:43 +0100
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, axboe@kernel.dk
Content-Transfer-Encoding: quoted-printable
Message-Id: <A32330F0-ADD6-43F8-B0EE-89A0D0568867@linaro.org>
References: <20191101131110.18356-1-dmonakhov@gmail.com>
To:     Dmitry Monakhov <dmonakhov@gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 1 nov 2019, alle ore 14:11, Dmitry Monakhov =
<dmonakhov@gmail.com> ha scritto:
>=20
> In most cases blk_tracing is not active, but  bfq_log_bfqq macro
> generate pid_str unconditionally, which result in significant =
overhead.
>=20
> ## Test
> modprobe null_blk
> echo bfq > /sys/block/nullb0/queue/scheduler
> fio --name=3Dt --ioengine=3Dlibaio --direct=3D1 --filename=3D/dev/nullb0=
 \
>   --runtime=3D30 --time_based=3D1 --rw=3Dwrite --iodepth=3D128 --bs=3D4k=

>=20
> # Results
> |        | baseline | w/ patch | gain |
> | iops   | 113.19K  | 126.42K  | +11% |
>=20

Thank you very much for this simple yet effective improvement.

Acked-by: Paolo Valente <paolo.valente@linaro.org>

> Signed-off-by: Dmitry Monakhov <dmonakhov@gmail.com>
> ---
> block/bfq-iosched.h | 4 ++++
> 1 file changed, 4 insertions(+)
>=20
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 5d1a519..b320fe9 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -1062,6 +1062,8 @@ struct bfq_group *bfqq_group(struct bfq_queue =
*bfqq);
>=20
> #define bfq_log_bfqq(bfqd, bfqq, fmt, args...)	do {			=
\
> 	char pid_str[MAX_PID_STR_LENGTH];	\
> +	if (likely(!blk_trace_note_message_enabled((bfqd)->queue)))	=
\
> +		break;							=
\
> 	bfq_pid_to_str((bfqq)->pid, pid_str, MAX_PID_STR_LENGTH);	=
\
> 	blk_add_cgroup_trace_msg((bfqd)->queue,				=
\
> 			bfqg_to_blkg(bfqq_group(bfqq))->blkcg,		=
\
> @@ -1078,6 +1080,8 @@ struct bfq_group *bfqq_group(struct bfq_queue =
*bfqq);
>=20
> #define bfq_log_bfqq(bfqd, bfqq, fmt, args...) do {	\
> 	char pid_str[MAX_PID_STR_LENGTH];	\
> +	if (likely(!blk_trace_note_message_enabled((bfqd)->queue)))	=
\
> +		break;							=
\
> 	bfq_pid_to_str((bfqq)->pid, pid_str, MAX_PID_STR_LENGTH);	=
\
> 	blk_add_trace_msg((bfqd)->queue, "bfq%s%c " fmt, pid_str,	=
\
> 			bfq_bfqq_sync((bfqq)) ? 'S' : 'A',		=
\
> --=20
> 2.7.4
>=20

