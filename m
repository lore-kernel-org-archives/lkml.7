Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6702C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E3F2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556188167;
	bh=eNrv5UrP9L6BsclZYbT7L2DpxpieXYZWg/6ctIGmqms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FuNclZeEZ8voe8vr8Z7DXUVyIMnfegDFdYl4XSWimwvvguRvEO0KgL/LqqQZdrJio
	 yRO/Aqa3gAeryVhTDkc40gBvu1C1pimFqe0YgymZ/0JSoePF6SPdQHljgOXeAh8otx
	 Zw40HszjCBnXvVPYQLp6UrGwBr/L5KR//kAMej80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbfDYK30 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:29:26 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35531 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfDYK3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:29:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id m10so18962360otp.2;
        Thu, 25 Apr 2019 03:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NaEO2hbJnAfSocLc5D5wA6ojFT1ikDji2rc336ze4Z8=;
        b=QqWf1xwulkEBHpxv/hMe5ElOQ5VmwZEXr9Wh/I7Vb3u6hZjO+RA2dBJFrTuliPfCNY
         kFj/X/iTFueTe0U/S+XOLp3ryul9lf9yKytUxYEC0d8xfZ6bX4Ao2wSO2uSZYEiCiG3w
         UWJ2iF1kIFwMaPmNXr8kP27RHs9j93j7PWoRCwzjw+o7hhpMTKBOZSNzygPJgqE9wglE
         Nh+f7uZayV8Bag4Jca2FfQI0UL3BLG7kWC4EewZ1PETfQxEZx8syndwpk94R+g6O9L+R
         sv7VaZr1KorCDya+WIaAnBjMVOD2GI06vtdihq6ssKF37CCDBnow4uEzjTZTfhXTZF+2
         ZzkQ==
X-Gm-Message-State: APjAAAVn7S89zlOOlrSb6CNRmCxbG9vFLxuDn6xjRTCTu4q72agW62ge
        WFtDrCLHSFVGckFJH+0La2d7KHtaZjUXN1Gotvs=
X-Google-Smtp-Source: APXvYqw3NB5FFAFcBBhNbDiq0JrF1J0ZYM/WZJ7qsjLnZ2oD/chnauzFJOzvJGycLTCYTL/SMIVYBXvlG1LiTEN03pw=
X-Received: by 2002:a05:6830:20cd:: with SMTP id z13mr23847099otq.168.1556188165036;
 Thu, 25 Apr 2019 03:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <1556185703-26243-1-git-send-email-vabhav.sharma@nxp.com>
 <CAJZ5v0iwrjonKpA3Skkhkg3g5Pp9Qzx0v2GBYKdv7eM_jL4p8g@mail.gmail.com> <VI1PR04MB43336A0C62B956CA29A7E621F33D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB43336A0C62B956CA29A7E621F33D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Apr 2019 12:29:13 +0200
Message-ID: <CAJZ5v0jQFXpHmpxSYSUxwGkMV98g3S+zV1oh1RYxvkebmzT29Q@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2] clk: qoriq: Add clockgen support for lx2160a
To:     Andy Tang <andy.tang@nxp.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 12:15 PM Andy Tang <andy.tang@nxp.com> wrote:
>
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: 2019年4月25日 18:04
> > To: Vabhav Sharma <vabhav.sharma@nxp.com>
> > Cc: linux-kernel@vger.kernel.org; linux-clk@vger.kernel.org;
> > linux-pm@vger.kernel.org; sboyd@kernel.org; mturquette@baylibre.com;
> > rjw@rjwysocki.net; viresh.kumar@linaro.org; Yogesh Narayan Gaur
> > <yogeshnarayan.gaur@nxp.com>; Andy Tang <andy.tang@nxp.com>
> > Subject: [EXT] Re: [PATCH v2] clk: qoriq: Add clockgen support for lx2160a
> >
> > Caution: EXT Email
> >
> > On Thu, Apr 25, 2019 at 11:48 AM Vabhav Sharma <vabhav.sharma@nxp.com>
> > wrote:
> > >
> > > From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > >
> > > Add clockgen support for lx2160a.
> > > Added entry for compat 'fsl,lx2160a-clockgen'.
> >
> > Well, if I'm expected to apply this, the above is a bit terse.
> >
> > It looks like the patch makes the qoriq-cpufreq driver handle some new
> > hardware, but the changelog doesn't say much about that.
> >
> > I'm guessing that the clockgen support added here makes it possible for
> > qoriq-cpufreq to handle this chip, is that correct?
> Yes, your guess is correct. The cpufreq feature is based on clock driver.
> It should had been separated to two patches and reduced the confuse.
> Do I need to update the commit message or you just take it?

Please update the commit message.

Thanks!
