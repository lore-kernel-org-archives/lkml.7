Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA18C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D45267BF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aI2iy5Ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfEaKvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 06:51:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40089 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfEaKvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 06:51:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id q62so9149030ljq.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 03:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eSFdj8v/B2hn6eq+aISdcOvbu5JLjtu1Vr8ajLwYUNk=;
        b=aI2iy5Ad/wjTGlIM92kqSiFz7uuJXxsM4eJMJ/DVQV+jWAHN/0CCQdN+93pDoASKW9
         1N0dBNSnQUw0G6ZDZ9KUpi+mbRf++fvqXn0fUiFF2pJFaeGvJ1uZrgTZJHYFBNO1Emlb
         DXttEAlqIbd+pj1EjNkAAAi3maQwCR/z04iq1mrqS0wpw+vAY5wBbbbWHTMNBeiYjXMa
         z8+ENbh7A7egZLdTl9rXCxRvePZBbywJKlAFC3GxtpqrtQ4CZvB0u/GPu5c9r9xgPOwE
         KhLLA1yqyzf89NSVW+imIs4ICPDL5sGnFB8n6eUDeQNsoKR8oY6nkVNDBzshJOVxAd89
         Uhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eSFdj8v/B2hn6eq+aISdcOvbu5JLjtu1Vr8ajLwYUNk=;
        b=d43ac6I4AR/A9THjaaxSG9I73EPKzhiNh+rj5qtTA4YYbb2pZ9rApz5BpsCSiiztEk
         l+R5jRGypi+MzJ4TY+kD/QmrvhapCob5JdM8C8Hdckxkp4r0PAXzPR5bhFseEnlVY2hr
         Kb37rUWzPuHCwEpwMuHaQvculGU0Ka4LwiU5eRExKXEEFCWd65q2yUzwzbVX9rbEaLfD
         jwTeHay2FSvuy9YCniRDA1gVBH8ZDrjRhiPL9sKvHmOTEJbrZLxJ7687MnxoouDepzfM
         5ec7q8FW4YEOeJJNCJ47JdvLmbWP4IGTZ/BuGcBa/8ORBJEpI8HYnUNSV6YnquOkk5ZS
         prog==
X-Gm-Message-State: APjAAAUS0OxbkXsFJhvtevqFkF+nOn4slDlBqEAmTnZF6BlQ8mrmzqQu
        yAoJscQ3MeiagbMhD43IxyrJGx36ZZJBjxcEYPdxMQ==
X-Google-Smtp-Source: APXvYqxDnzlPXNU+Y5DTaA2BPB+vxJPMWOGT2RoVnJiU+Yk0Rw8NoHYd3Xpa8pVi6m3Tfl2myIAXKSoBTK3XNFk1VOg=
X-Received: by 2002:a2e:8902:: with SMTP id d2mr5474176lji.94.1559299909636;
 Fri, 31 May 2019 03:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190516085018.2207-1-masneyb@onstation.org> <20190520142149.D56DA214AE@mail.kernel.org>
 <CACRpkdZxu1LfK11OHEx5L_4kyjMZ7qERpvDzFj5u3Pk2kD1qRA@mail.gmail.com> <20190529101231.GA14540@basecamp>
In-Reply-To: <20190529101231.GA14540@basecamp>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 31 May 2019 12:51:38 +0200
Message-ID: <CACRpkdY-TcF7rizbPz=UcHrFvDgPJD68vbovNdcWP-aBYppp=g@mail.gmail.com>
Subject: Re: [PATCH RESEND] ARM: dts: qcom: msm8974-hammerhead: add device
 tree bindings for vibrator
To:     Brian Masney <masneyb@onstation.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 12:12 PM Brian Masney <masneyb@onstation.org> wrote:

> My first revision of this vibrator driver used the Linux PWM framework
> due to the variable duty cycle:

So what I perceive if I get the thread right is that actually a lot of
qcom clocks (all with the M/N/D counter set-up) have variable duty
cycle. Very few consumers use that feature.

It would be a bit much to ask that they all be implemented as PWMs
and then cast into clocks for the 50/50 dutycycle case, I get that.

What about simply doing both?

Export the same clocks from the clk and pwm frameworks and be
happy. Of course with some mutex inside the driver so that it can't
be used from both ends at the same time.

Further Thierry comments
https://lore.kernel.org/lkml/20181012114749.GC31561@ulmo/

> The device itself doesn't seem to be a
> generic PWM in the way that the PWM framework
> expects it.

I don't see why.  I just look at this function from the original
patch series:

+static int msm_vibra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+ int duty_ns, int period_ns)
+{
+ struct msm_vibra_pwm *msm_pwm = to_msm_vibra_pwm(chip);
+ int d_reg_val;
+
+ d_reg_val = 127 - (((duty_ns / 1000) * 126) / (period_ns / 1000));
+
+ msm_vibra_pwm_write(msm_pwm, REG_CFG_RCGR,
+    (2 << 12) | /* dual edge mode */
+    (0 << 8) |  /* cxo */
+    (7 << 0));
+ msm_vibra_pwm_write(msm_pwm, REG_M, 1);
+ msm_vibra_pwm_write(msm_pwm, REG_N, 128);
+ msm_vibra_pwm_write(msm_pwm, REG_D, d_reg_val);
+ msm_vibra_pwm_write(msm_pwm, REG_CMD_RCGR, 1);
+ msm_vibra_pwm_write(msm_pwm, REG_CBCR, 1);
+
+ return 0;
+}

How is this NOT a a generic PWM in the way that the PWM
framework expects it? It configures the period and duty cycle on
a square wave, that is what a generic PWM is in my book.

Yours,
Linus Walleij
