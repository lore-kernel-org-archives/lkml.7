Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289B5C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 00:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018D22186A
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 00:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ngcmAUYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfH1Abs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 20:31:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41834 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfH1Abr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 20:31:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id 196so466748pfz.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 17:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=6DZabq8OOFr7SZFMrBCsezS6Py1mMQ+cwU1PePGAkIE=;
        b=ngcmAUYZXtJo08EKY/VBWkbR9Y6m5d18wyRsXJer8ur7SxM9k+agOqehuEdH+Ycfdy
         Pi+EmEsEwOnOxG36KNKWz8e3uqLo+w3XInaErt/dXflVRpust3rsqo3sHIA5aMTfgf1p
         +Mc9OLlWFa+tmIaaicyodHEeYt7jVea8ulCTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=6DZabq8OOFr7SZFMrBCsezS6Py1mMQ+cwU1PePGAkIE=;
        b=V3Sv6SoURmxFKW/hIQ4usw00B7ynobL0C+JXs7yVMUm6G76EVg73FJe5OoactNqyai
         gXzk+awaQ9JTWvJONIM7KSI15xcTePaMf0xxa9sbIOfHiInTUObVgf6PC+lUPV4d+RS+
         JvtXZRfc2sPANwraFwVezuYAbAPCOlPG9ZKqZeg/Bq3yB+dnWK5dc6HhZWVBdqDPWnNS
         nMHAlZctEwlv7/+UMz1b6pTWw8ihIvzJeZu4CrHJejG1/yGgM2exnkTzlQQoOY5Mpzy+
         gIlW6nmYMSUUZoKyTJIeFZ5KNzVJCJGqRzacPB5g3K+iOH6oBQE4JzPOFieZsj2GMB80
         LS5A==
X-Gm-Message-State: APjAAAV0bhL/li0J/ZbgiI29LdbHhRMDXLHw1zvVyU7V3kLD+HFS9kMW
        9XAACdbsEK+bf7sFFIBagOYzEA==
X-Google-Smtp-Source: APXvYqyTAY2DIrm/6oafpYk02AMmWsUOJ5l6X62U+poE3/LzEAZrdfqAN9ZcibbeX1gFo/FrO0+5rQ==
X-Received: by 2002:a17:90b:f12:: with SMTP id br18mr1374786pjb.127.1566952306919;
        Tue, 27 Aug 2019 17:31:46 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a6sm508542pfa.162.2019.08.27.17.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 17:31:46 -0700 (PDT)
Message-ID: <5d65cb72.1c69fb81.5472a.24f4@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f41f53a77406c782042c0a27c180c99859b0673f.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org> <f41f53a77406c782042c0a27c180c99859b0673f.1566907161.git.amit.kucheria@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 04/15] drivers: thermal: tsens: Add debugfs support
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.w.gonzalez@free.fr, masneyb@onstation.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 27 Aug 2019 17:31:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-08-27 05:14:00)
> Dump some basic version info and sensor details into debugfs. Example
> from qcs404 below:
>=20
> --(/sys/kernel/debug) $ ls tsens/
> 4a9000.thermal-sensor  version
> --(/sys/kernel/debug) $ cat tsens/version
> 1.4.0
> --(/sys/kernel/debug) $ cat tsens/4a9000.thermal-sensor/sensors
> max: 11
> num: 10
>=20
>       id    slope   offset
> ------------------------

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

