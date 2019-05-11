Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79659C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 16:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AEB2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 16:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="rcpIKEhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfEKQaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 12:30:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37883 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfEKQaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 12:30:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id r10so7530093otd.4;
        Sat, 11 May 2019 09:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yijEGAnLVzr4Lwt1Vrh28KdYgoNEEafxViUlvjT5JGo=;
        b=rcpIKEhZNdOQzU7Czvong9jUlaMpccz8Y8FA7g74NbJ4E3DL3/Eok7D+GPUNjDKrzw
         DNFhPckx9I2EBS/t4G/aL65d6TDuQuGr5cuBkpiCCJVTvrFeiKgHL7YBBJlKttb84QgV
         3XBDCzPfHy23MRgt1XNNYXxto8XemP8nZ6fvFrUpDWSw2Dg78eEfm3wjtoUmn70+wZcu
         cPEvgPdRK31bxUGooJRfRaXSGxKNRgg6DVpJ5ajonvPB//UcuXs8thQKYvu1B5MpQOfJ
         tQEoY83DYwN27MerKnJOVmawXSq5+awGKGx7/8ApmZTdYEAlqFYTIAVUqg7lsOcb8Dan
         ZNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yijEGAnLVzr4Lwt1Vrh28KdYgoNEEafxViUlvjT5JGo=;
        b=inx4zEdVGNiQeqVOpIXJt4cCc+3dDfcRXZy5hGDiCg2kdaHxK6vdjeLiDNmUIMDd5z
         cbrfmgecvZNij0+9PC7yYSvaebPOm0OX4yozmqaAiIqXtgfTH9UEzQNlCqHahE0KdBfj
         Z8vZtpAoJ6nILQtejgPi130z92zC7pN1SfyRS4k0FuzK4RQ6eDeeXbbM5+GAkVgvxcqK
         3IqVv/gPwnXieY0GCPojl/fHERzEc5kg9LDt+CzofZES6XnlGOBcLVv7IIlDZdoKEpbb
         0fbcMY2DQXUHdoAIiuTGJUVj409s/qObybnqyYBFVJ28M5vy/OiiLEZMBZatXBXRPGTv
         PLyg==
X-Gm-Message-State: APjAAAUqLU6dVJOzjTA9y+qpuAxPdjV1qKHgg53Ezw0T5CzczXWwbiiY
        IVRlktJZCFHo8sCDtCyLlJPQLyqs1Qua2vmzr9k=
X-Google-Smtp-Source: APXvYqxFpF2Vp0nTmlVZJemYyfFM6MjceS3IhH2OHGnJaC6ACavQCXa8yag/oqTVRe1PjzlLeyiOSEIbvfsU1UqGrCU=
X-Received: by 2002:a9d:76d5:: with SMTP id p21mr8248186otl.308.1557592211780;
 Sat, 11 May 2019 09:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190510082324.21181-1-glaroque@baylibre.com> <20190510082324.21181-7-glaroque@baylibre.com>
In-Reply-To: <20190510082324.21181-7-glaroque@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 May 2019 18:30:01 +0200
Message-ID: <CAFBinCBeh6eUQFFJ_HTzEtnrsoyq35QKfG6NpZF51=euCBZ6sw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] pinctrl: meson: g12a: add DS bank value
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     linus.walleij@linaro.org, khilman@baylibre.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        jbrunet@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 10:23 AM Guillaume La Roque
<glaroque@baylibre.com> wrote:
>
> add drive-strength bank regiter and bit value for G12A SoC
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>
