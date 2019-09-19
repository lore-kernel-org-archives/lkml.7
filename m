Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F57C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 19:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0BB21924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 19:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AOWoIL06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404519AbfISTwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 15:52:02 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44891 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404506AbfISTwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 15:52:01 -0400
Received: by mail-oi1-f194.google.com with SMTP id w6so3753729oie.11;
        Thu, 19 Sep 2019 12:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5TGlGC+JLaD/AldQw5ZGualV4WVo3kjSxq0zFR0ZtbU=;
        b=AOWoIL06JK00MJztsJhQJPncAFu0EnZglQ7WbeZ4O0m2Gzt6yfmanZafgvK2NegZ5o
         tzfC/vtmhpnw4e2Hx4AG1tNNkCygq/DQrzx99M1VCysTiR4C69BOHu59RTDJDxaj1aWE
         NVE9WYNSg8p75UxldE+NVw5azNkhgAkdVvxv3ztDTvZSNhTp4Yc5SLjjnCZgWSVe9TYK
         tZ0nOkWrR1PCJiu7fUtMqq3vTmB7cMAh7krUbfE5/Ny5OGmc3JizjlTM4o+QqUTGjAL3
         SOa2SeZD4nWEmwVg1q90VDNwKmtxb1MyEvKFSzZ7KzRiY4LRj05q/SnV6w+tedmv/W5S
         OBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5TGlGC+JLaD/AldQw5ZGualV4WVo3kjSxq0zFR0ZtbU=;
        b=Xt/uoxW0GwCyGvRbpGk9DTRe7i8+H2l4znAkCjDaHCJugjE80aWr+jY063CelOW7Qh
         Xebq1mjdZbxvHvh9K6CjbEyHQgHPXc1koY3kmxNLyfL5d6fqiXn5CfYGFp0u2Q3bHrkp
         YclthBRoWx90DI5tNHZD+kQAPOlv1VDJzSbC/9WQ4S2ZKt6JGYQDoxnWbb3LpYGXUKOx
         a9eQS6R//Vf/gmC6TtaE90t3y6yTM/l1InGmDSSP1eSENwh8BI5VdjXpmMujv6SLhu55
         ReGBVbBn/Smq0wYjsPuR3E9w0237betVn5IvT5uPZqpLhgZ5gPas8J2XIPU4o+1sxTVW
         HiEQ==
X-Gm-Message-State: APjAAAU8O9/K2YNCpPjaUYMsF3LmqynWlbc6yRHGa4Kng677W/HlJI4l
        uZsZhJInFZ/NcYENx7NnbqWngprMZ4dOVRDGFjU=
X-Google-Smtp-Source: APXvYqxRpe7ZDiMV3MjvAdU49+4Mmk19JBcGeqjdlSMgYHLipUrCVTVISZMUupnGn493/BXmTVMqkM+p+VrHLLKaQjY=
X-Received: by 2002:aca:3ad6:: with SMTP id h205mr3862718oia.129.1568922720335;
 Thu, 19 Sep 2019 12:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <90cc600d6f7ded68f5a618b626bd9cffa5edf5c3.1566531960.git.eswara.kota@linux.intel.com>
 <3813e658-1600-d878-61a4-29b4fe51b281@linux.intel.com> <CAFBinCA_B9psNGBeDyhkewhoutNh6HsLUN+TRfO_8vuNqhis4Q@mail.gmail.com>
 <48b90943-e23d-a27a-c743-f321345c9151@linux.intel.com> <CAFBinCD1oKxYm8QD7XfZUWq_HC5A4GLMmLCnZrcRvpTxrKo30w@mail.gmail.com>
 <19719490-178a-18fd-64f2-f77d955897f7@linux.intel.com> <CAFBinCDmi4HN4Ayg4T8aKUeu4hrUmVQ+z-hTN-6XMhiOCUcHjg@mail.gmail.com>
 <34336c9a-8e87-8f84-2ae8-032b7967928f@linux.intel.com> <CAFBinCDfM3ssHisMBKXZUFkfoAFw51TaUuKt_aBgtD-mN+9fhg@mail.gmail.com>
 <657d796d-cb1b-472d-fe67-f7b9bf12fd79@linux.intel.com> <CAFBinCA5sRp1-siqZqJzFL2nuD3BtjrbD65QtpWbnTgtPNXY1A@mail.gmail.com>
 <cebd8f1d-90ab-87e7-9a34-f5c760688ce5@linux.intel.com> <CAFBinCCXo50OX6=8Fz-=nRKuELU_fMOCX=z6iwAcw0_Tfgn1ug@mail.gmail.com>
 <da347f1c-864c-7d68-33c8-045e46651f45@linux.intel.com> <CAFBinCDhLYmiORvHdZJAN5cuUjc6eWJK5n9Qg26B0dEhhqUqVQ@mail.gmail.com>
 <389f360a-a993-b9a8-4b50-ad87bcfec767@linux.intel.com>
In-Reply-To: <389f360a-a993-b9a8-4b50-ad87bcfec767@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 19 Sep 2019 21:51:48 +0200
Message-ID: <CAFBinCBwrTajCrSf-UqZY5gHqUSn0UTmbc_TLPNVZrPyY5jpOA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] reset: Reset controller driver for Intel LGM SoC
To:     Dilip Kota <eswara.kota@linux.intel.com>, p.zabel@pengutronix.de
Cc:     "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>,
        cheol.yong.kim@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        robh@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dilip,

(sorry for the late reply)

On Thu, Sep 12, 2019 at 8:38 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
[...]
> The major difference between the vrx200 and lgm is:
> 1.) RCU in vrx200 is having multiple register regions wheres RCU in lgm
> has one single register region.
> 2.) Register offsets and bit offsets are different.
>
> So enhancing the intel-reset-syscon.c to provide compatibility/support
> for vrx200.
> Please check the below dtsi binding proposal and let me know your view.
>
> rcu0:reset-controller@00000000 {
>      compatible= "intel,rcu-lgm";
>      reg = <0x0000000 0x80000>, <reg_set2 size>, <reg_set3 size>,
> <reg_set4 size>;
I'm not sure that I understand what are reg_set2/3/4 for
the first resource (0x80000 at 0x0) already covers the whole LGM RCU,
so what is the purpose of the other register resources

>     intel,global-reset = <0x10 30>;
>     #reset-cells = <3>;
> };
>
> "#reset-cells":
>    const:3
>    description: |
>      The 1st cell is the reset register offset.
>      The 2nd cell is the reset set bit offset.
>      The 3rd cell is the reset status bit offset.
I think this will work fine for VRX200 (and even older SoCs)
as you have described in your previous emails we can determine the
status offset from the reset offset using a simple if/else

for LGM I like your initial suggestion with #reset-cells = <2> because
it's easier to read and write.

> Reset driver takes care of parsing the register address "reg" as per the
> ".data" structure in struct of_device_id.
> Reset driver takes care of traversing the status register offset.
the differentiation between two and three #reset-cells can also happen
based on the struct of_device_id:
- the LGM implementation would simply also use the reset bit as status
bit (only two cells are needed)
- the implementation for earlier SoCs would parse the third cell and
use that as status bit

Philipp, can you please share your opinion on how to move forward with
the reset-intel driver from this series?
The reset_control_ops from the reset-intel driver are (in my opinion)
a bug-fixed and improved version of what we already have in
drivers/reset/reset-lantiq.c. The driver is NOT simply copy and paste
because the register layout was greatly simplified for the newer SoCs
(for which there is reset-intel) compared to the older ones
(reset-lantiq).
Dilip's suggestion (in my own words) is that you take his new
reset-intel driver, then we will work on porting reset-lantiq over to
that so in the end we can drop the reset-lantiq driver. This approach
means more work for me (as I am probably the one who then has to do
the work to port reset-lantiq over to reset-intel). I'm happy to do
that work if you think that it's worth following this approach.
So I want your opinion on this before I spend any effort on porting
reset-lantiq over to reset-intel.


Martin
