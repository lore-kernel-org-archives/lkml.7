Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0546C2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DBF20409
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A2huiwkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfL3TaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:30:22 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41594 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfL3TaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:30:22 -0500
Received: by mail-ot1-f68.google.com with SMTP id r27so47404347otc.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 11:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FWVYjFfIIe+qY04H734qWucJ1T7JU5SJXMfcm3nyZe8=;
        b=A2huiwkMJ6SdcgAICeEHmr+07krTJrt3VjY13ea54T6c88+FuO+LnG9GQCgV1X8POI
         lhISAEjoPpzErokSmTog+0tBPZdNbW+sM9v6BcJX91cPA3kYUmbGFk3fOJb2wRrSKGyq
         Z/LBK9gmn2GJHBV8S2MecPheW56GHJV6I2nN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FWVYjFfIIe+qY04H734qWucJ1T7JU5SJXMfcm3nyZe8=;
        b=Khs+ioAuW8fYGn34pkmHu/CKYfpQjTKJ++RB/WtyIUWQVCL4gpZk4+gSu5jJdS0VVp
         F5ngjXVRl+Hh0KPIXqB0CpliBTSi+ToqzLTCZUHOj6Bn5+zkoE622co02vVeJUlGnFXE
         kjkZt95EnublCIC/jUCCZ9CRF9lO/LuOn85ZBcZLXmAmBV19jW0Iog2OywFGslhhmDK4
         cGZMucAoaVc4ck+Olu5ZGAoGOIMFZb1HTM7Utea5UlbIaBaAAssklsG8kj+o+fYnMcIJ
         9YE+I+Ss5deWed367BBDk2fRRyLQwSEXI0ywUW6L7UpBbUsl7hApWUyEdt0pViSzdsuq
         QoQw==
X-Gm-Message-State: APjAAAX81+tqgP8fWxLpOS3gEjXju/+jQHLFM64YVXCCKZhDCqxEJss/
        z+QGk5NazX+0WhoRwkeOfcCjQQ==
X-Google-Smtp-Source: APXvYqylwQx/pxF9jNXq8V9+2c/EaY/yAeM5ESWygh8UA426HKAmV3tZgouZQbhsGnnQMhE/2md2DQ==
X-Received: by 2002:a9d:650f:: with SMTP id i15mr58642823otl.97.1577734221397;
        Mon, 30 Dec 2019 11:30:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j186sm8998876oih.55.2019.12.30.11.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 11:30:20 -0800 (PST)
Date:   Mon, 30 Dec 2019 11:30:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF (KRSI)
Message-ID: <201912301128.B37D55AB44@keescook>
References: <20191220154208.15895-1-kpsingh@chromium.org>
 <a6b61f33-82dc-0c1c-7a6c-1926343ef63e@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6b61f33-82dc-0c1c-7a6c-1926343ef63e@digikod.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 11:46:47PM +0100, Mickaël Salaün wrote:
> I'm working on a version of Landlock without eBPF, but still with the
> initial sought properties: safe unprivileged composability, modularity, and
> dynamic update. I'll send this version soon.
> 
> I hope that the work and experience from Landlock to bring eBPF to LSM will
> continue to be used through KRSI. Landlock will now focus on the
> unprivileged sandboxing part, without eBPF. Stay tuned!

Will it end up looking at all like pledge? I'm still struggling to come
up with a sensible pledge-like design on top of seccomp, especially
given the need to have it very closely tied to the running libc...

-- 
Kees Cook
