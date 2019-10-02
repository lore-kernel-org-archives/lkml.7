Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E1AC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCC121848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dAaTHI5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfJBXoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 19:44:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42975 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfJBXoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 19:44:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id q12so489934pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 16:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9o+aVMafZNh1ZBc9I6ckxlik1QiG/UvW5Wt+nH2rOMs=;
        b=dAaTHI5NhKSOqh6X6vkUfZ7fxdK8NudPU+TFuLPA2/jL2ZjXBajNS/ZZXlY0LtMGim
         5jl36gvqdRy5B9s4xlzgNLd4mMLzy6DbGCqCMtrfoByESBlb9hYL3ufD/mroNDBvKsP6
         U54jM3ho8xbwaGpnQ3U7OYJIiZ3ZqPnpCsQQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9o+aVMafZNh1ZBc9I6ckxlik1QiG/UvW5Wt+nH2rOMs=;
        b=nrXiGhTqQLgqjlLpnypVwl3shL53OQeCZXQdRJsnGC5u2GYP7L0pVAPBKJi6jkNqDJ
         c8Gyr6gTVg1HgQFlqtdSimp9VNZO2nYk7n77wJRh7/9OeqkyaTNaNFFH4jv5vfJ1Ohqr
         tNGrimufWO44xv91VZFgYgqmqfuQFB2HHp9W1N89WajQVjp1sX5NmiOPp/wthG0UNu/X
         zSg6A9d/iJSMIjumSHYfellorUPLNcngrO5ACxJCFpSfWZNcQ1V307vZOA5ZfJgrP3T3
         kQTXbxRvyTU/ZzAF/53tJS2BeGxSE0jhAmaMOSF5xZ+ynu8crX102eu0p1KZqbYOOaeN
         c1Hw==
X-Gm-Message-State: APjAAAVj6u1mJg1It1vR7fANXhUkImjWUA1TbZGjlKYoi7LJXnGvpwQL
        QYx+ZFseHyv5WwVftmcz/G9Zzw==
X-Google-Smtp-Source: APXvYqx7tAiFYBlhceMShOLU4glxP11l0ZXEXx/4CKfroBA38HHANDXcLnns13A63AD43NhZQaLhQA==
X-Received: by 2002:a62:b40a:: with SMTP id h10mr7621495pfn.88.1570059878236;
        Wed, 02 Oct 2019 16:44:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id b22sm552757pfo.85.2019.10.02.16.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 16:44:37 -0700 (PDT)
Date:   Wed, 2 Oct 2019 16:44:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: rockchip: Use interpolated brightness tables
 for veyron
Message-ID: <20191002234436.GI87296@google.com>
References: <20191001160735.1.Ic9fd698810ea569c465350154da40b85d24f805b@changeid>
 <CAD=FV=UnZtGN142yUu-NzVG00P=1MZ-X3aY+cjrMRCnL2D8xFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=UnZtGN142yUu-NzVG00P=1MZ-X3aY+cjrMRCnL2D8xFg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 03:23:54PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Oct 1, 2019 at 4:07 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > --- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
> > +++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
> > @@ -39,39 +39,8 @@
> >
> >  &backlight {
> >         /* Minnie panel PWM must be >= 1%, so start non-zero brightness at 3 */
> > -       brightness-levels = <
> > -                         0   3   4   5   6   7
> > -                         8   9  10  11  12  13  14  15
> > -                        16  17  18  19  20  21  22  23
> > -                        24  25  26  27  28  29  30  31
> > -                        32  33  34  35  36  37  38  39
> > -                        40  41  42  43  44  45  46  47
> > -                        48  49  50  51  52  53  54  55
> > -                        56  57  58  59  60  61  62  63
> > -                        64  65  66  67  68  69  70  71
> > -                        72  73  74  75  76  77  78  79
> > -                        80  81  82  83  84  85  86  87
> > -                        88  89  90  91  92  93  94  95
> > -                        96  97  98  99 100 101 102 103
> > -                       104 105 106 107 108 109 110 111
> > -                       112 113 114 115 116 117 118 119
> > -                       120 121 122 123 124 125 126 127
> > -                       128 129 130 131 132 133 134 135
> > -                       136 137 138 139 140 141 142 143
> > -                       144 145 146 147 148 149 150 151
> > -                       152 153 154 155 156 157 158 159
> > -                       160 161 162 163 164 165 166 167
> > -                       168 169 170 171 172 173 174 175
> > -                       176 177 178 179 180 181 182 183
> > -                       184 185 186 187 188 189 190 191
> > -                       192 193 194 195 196 197 198 199
> > -                       200 201 202 203 204 205 206 207
> > -                       208 209 210 211 212 213 214 215
> > -                       216 217 218 219 220 221 222 223
> > -                       224 225 226 227 228 229 230 231
> > -                       232 233 234 235 236 237 238 239
> > -                       240 241 242 243 244 245 246 247
> > -                       248 249 250 251 252 253 254 255>;
> > +       brightness-levels = <3 255>;
> > +       num-interpolated-steps = <251>;
> 
> I _think_ you want:
> 
> brightness-levels = <0 3 255>;
> num-interpolated-steps = <252>;
> 
> Specifically:
> 
> * It seems like you're intending to keep everything the same and just
> have a more compact representation, right?

Ideally yes, I thought we were missing 1 level due to the 0 step being
missing, but it's actually 2, since I interpreted 'num-interpolated-steps'
as the number between two values in the table, however it is this number +1.

> Looking through the values in '/sys/class/backlight/backlight' on
> minnie shows differences before and after your patch.
> 
> * I think you want brightness of 0 to match to PWM level 0.

For level 0 that was actually given, due to

pwm_backlight_update_status()
{
  ..
  if (brightness > 0) {
    ...
  } else
    pwm_backlight_power_off(pb);
  ...
}

but we're slightly off for the rest of the levels.

> * If I put in printouts in the code with your table, I see:
> 
> pwm-backlight backlight: new number of brightness levels: 252
> pwm-backlight backlight: i=0, j=0, lc=0, value=3
> pwm-backlight backlight: i=0, j=1, lc=1, value=4
> ...
> pwm-backlight backlight: i=0, j=250, lc=250, value=253
> pwm-backlight backlight: lc=251, data->levels[i]=255
> 
> ...as you can see, you end up missing assigning a value of 254.

Thanks for investigating. With 'num-interpolated-steps' increased
by one this is fixed, though we are still missing one level at the
beginning of the table. I didn't expect 'brightness-levels = <0 3 255>'
to work, since there are less than 252/251 integer numbers between 0
and 3, but the code actually accounts for that case and just interprets
it as a single step, which is what we want.

Long story short: you are right, we want

brightness-levels = <0 3 255>;
num-interpolated-steps = <252>;
