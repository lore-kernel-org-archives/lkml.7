Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B213C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97A520663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfCEDzt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:55:49 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44791 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfCEDzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:55:48 -0500
Received: by mail-ot1-f68.google.com with SMTP id g1so6260716otj.11;
        Mon, 04 Mar 2019 19:55:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CCAeOTUBAqXIZ2ew+HhfRfFmQgWDQf4pIhwhvEu1EXo=;
        b=Z3NzqAm2x+jrMM2ZdFX9uo9eUjEIQIMjU3EtJnpJbjhlb4oaMRj3kFK5gNRfWzARA4
         Oczju4e7unt6zCoAg+GJraOB9atqzjhKkwvZCbhSRAXCymtjzp/rclGmGmdc/yfAKWoy
         Y41XeEKMfmGKEyD5u/C6il7rM3VZ9E/msQdkwqKzY8w80dv2vGKL5TYWsVMRM97CS6qd
         ZUvd+cfKxXgdTkoxwXMGTnF9g3Dnr9LlaQNcWUDlVPH53uHMeMbKj8sstptNz1BUXDEQ
         3CwzP+yX0EHhqKy3RPCnUbhHPKzUzLUQ9ltx3d60dbUHQZydtIW0n4ju2pKnLAwUwtju
         zB6Q==
X-Gm-Message-State: APjAAAVBZYTOs88Tva9/kWl3nUv1G03DuaI3HL97+VDDlSF/7qepZEu1
        TrSu62mHf9RKYGsxTiQuUCtAyqjYBqM=
X-Google-Smtp-Source: APXvYqyW6CfCo5o5snfnKZ6KY9csQbMGRB3zRpOIo/06Sto8lWbU5LmgtFglVJ9t/GT1LKpPHKA8kw==
X-Received: by 2002:a9d:7f8d:: with SMTP id t13mr14008898otp.92.1551758147891;
        Mon, 04 Mar 2019 19:55:47 -0800 (PST)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id h205sm3255951oib.11.2019.03.04.19.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 19:55:46 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id w66so5760929oia.4;
        Mon, 04 Mar 2019 19:55:46 -0800 (PST)
X-Received: by 2002:aca:c2c4:: with SMTP id s187mr709005oif.175.1551758146491;
 Mon, 04 Mar 2019 19:55:46 -0800 (PST)
MIME-Version: 1.0
References: <20190304035744.155203-1-alex.shi@linux.alibaba.com>
 <20190304035744.155203-2-alex.shi@linux.alibaba.com> <b2cb92de-ef4a-d628-0dd3-76d8d1b953d0@linux.alibaba.com>
 <CADRPPNSjf4P14bwUMsa10XzBUVLszx4iMsL6gk-XQ0x3vTFr+g@mail.gmail.com>
 <e342a3fa-20f6-46cd-4240-8403fa1aa736@linux.alibaba.com> <AM6PR04MB586370DDB6E73A43673339568F710@AM6PR04MB5863.eurprd04.prod.outlook.com>
 <CADRPPNTxDDquY=OT4MV6cQ8OHhAdbazMjngDhtRBCE9_UESg_w@mail.gmail.com> <c9ec2af6-82e2-4ac2-050f-d36622a25c55@linux.alibaba.com>
In-Reply-To: <c9ec2af6-82e2-4ac2-050f-d36622a25c55@linux.alibaba.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 4 Mar 2019 21:55:34 -0600
X-Gmail-Original-Message-ID: <CADRPPNQijagCppwVTQ5PNz-wfRHQLZF1a3taj2Ckk-Xn6iVDKg@mail.gmail.com>
Message-ID: <CADRPPNQijagCppwVTQ5PNz-wfRHQLZF1a3taj2Ckk-Xn6iVDKg@mail.gmail.com>
Subject: Re: [PATCH 01/20] docs/zh_CN: add disclaimer file
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     wezhang@outlook.com, Zhang Wei-r63237 <wei.zhang@freescale.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "harryxiyou@gmail.com" <harryxiyou@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 8:51 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
>
>
> On 2019/3/5 7:31 上午, Li Yang wrote:
> > Zhang Wei <wezhang@outlook.com>
> The only usage of 'Zhang wei' in kernel is freescale's driver maintainer. I am not sure the outlook.com address is better than Zhang Wei's freescale email address. So I'd rather leave this one to Zhang Wei himself.

He is no longer with Freescale/NXP now, the Freescale address wouldn't
work now.  So I think the outlook address would be better.

>
> Thanks
> Alex
>
> FREESCALE DMA DRIVER
> M:      Li Yang <leoyang.li@nxp.com>
> M:      Zhang Wei <zw@zh-kernel.org>
> L:      linuxppc-dev@lists.ozlabs.org
> S:      Maintained
