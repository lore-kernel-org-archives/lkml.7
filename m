Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AAAC5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D2E20650
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="elm90kH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfKFQi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:38:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46004 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfKFQi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:38:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id y24so11673789plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 08:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:to:cc:user-agent:date;
        bh=qbHs0l3jtZmX9NzpjDPZv6pUiwEN5GpXtvvaXol4cao=;
        b=elm90kH1LW2qo/Ri9hjM8t4+MKU5s46O05+XvvaVzw6Tk6QsGeIhF5YV00+D5pyK55
         rbLM3xgsdw2T/zZmMyOzJRfp9OkfsyRCeVk4+3kkeqjKRYcr3fQz98dGkG2+q1utpaec
         EVpRIF6pFijJyXB+eZpeEwjHMJ6H4NH9ugcJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:to:cc
         :user-agent:date;
        bh=qbHs0l3jtZmX9NzpjDPZv6pUiwEN5GpXtvvaXol4cao=;
        b=lse5TNxsGeUx2wxQcJ93hmfTCZyIgnf6ptHLSY/JcrK1TkD+hB4j232lObSb9Iuos8
         HMedoeNzWqaH3vKMwgyQYLdIYLNu9OJBa8jkELLX3F2i/hNCTMMsNwn0yqG257umyG9z
         ZLLpkmJ380WjppHz6rJtXM3vOPFe155JJtrwmKMKK2nmP8RrFLS0M7t+U9KSygR+FbiU
         mZNczGRiT0YoCE0D/At3MByzWLdmsihOrWN0i5V6aEzGl1vxMyail97WbAsx/7pAUw7C
         5HWjyAFNhBII+rowHdR6ty6mt66P2f+MJKDL14uydDaCKmHVrk3zmYKbJdoBTklXXiGR
         g52w==
X-Gm-Message-State: APjAAAXig5tw4UXFN7JxNUH6pGmAHk1NgaGdmV2v8BD45rn8wlkp1sbd
        9rYKbdLdLQnRVQ3xHRYuKd+qMg==
X-Google-Smtp-Source: APXvYqy2RaLyV21hruoJlfiV3tdaUV0LTkmePB8LMLIb7bdevYQZM5ZaXiHbw1o5htY4GWjJdRuScw==
X-Received: by 2002:a17:902:6b88:: with SMTP id p8mr244048plk.336.1573058335243;
        Wed, 06 Nov 2019 08:38:55 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c9sm35355894pfb.114.2019.11.06.08.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 08:38:54 -0800 (PST)
Message-ID: <5dc2f71e.1c69fb81.8912a.f2c0@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c4cee81775c6d82024ca05250290f603@codeaurora.org>
References: <1572931309-16250-1-git-send-email-kgunda@codeaurora.org> <5dc1cb4c.1c69fb81.af253.0b8a@mx.google.com> <c4cee81775c6d82024ca05250290f603@codeaurora.org>
Subject: Re: [PATCH V2] mfd: qcom-spmi-pmic: Add support for pm6150 and pm6150l
From:   Stephen Boyd <swboyd@chromium.org>
To:     kgunda@codeaurora.org
Cc:     Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        lee.jones@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rnayak@codeaurora.org
User-Agent: alot/0.8.1
Date:   Wed, 06 Nov 2019 08:38:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting kgunda@codeaurora.org (2019-11-05 22:43:59)
> On 2019-11-06 00:49, Stephen Boyd wrote:
> > Quoting Kiran Gunda (2019-11-04 21:21:49)
> >> Add the compatibles and PMIC ids for pm6150 and pm6150l PMICs
> >> found on SC7180 based platforms.
> >>=20
> >> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> >> ---
> >>  - Changes from V1:
> >>    Sorted the macros and compatibles.
> >=20
> > I don't see anything sorted though.
> >=20
> Sorry .. I might have misunderstood your comment. Let me know if my=20
> understanding is correct.
>=20
> >>>> And compatible here.
> >>> And on macro name here.
>=20
> This means you want to sort all the existing compatible and macros in=20
> alpha numeric order ?

Sorry I also got confused on what the driver is doing. I replied on the
original patch with what is preferred.

