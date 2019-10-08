Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9D6C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CBC21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="knQcBopp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfJHPdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:33:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43052 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfJHPdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:33:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id a2so10961901pfo.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 08:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=30tHV2fpMdwSf4U9d4O4ZBn5WVVTESOFWc1UPoBwGi8=;
        b=knQcBoppV5bduwoeAAh2N6H08y+Fapq4qcw2DwVm/+4fWjhia/XOwvbIfxUvsaPHyu
         bDlRXFz85p4aSyGuHU2fvB6DGhxq9ZAlFxFeMw6vMyx1qcSXfJqbOfJwDYg1FjQl78SO
         8r9CpjooqD0ruv0isbzS8slaNlH1LCWLcwqz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=30tHV2fpMdwSf4U9d4O4ZBn5WVVTESOFWc1UPoBwGi8=;
        b=K3+KS61BFnPWUlVd9ZSJrj+UzJMeNGDWAcb0siRQdh1Pt8zxYzehPQNy0/fobSOgsD
         7fAd4rvOTl0CkbXKABScOknS2WgJ4UUPpqF2Ln/7VM8FimszmgCdR2s6dzC/bBUdhwls
         zsCythRykvf4kBmqzMHdkReAHdA2QJk3/6N7y7f5q8tAN2NNCj03Be6wlc18UtMIjWDK
         e+J6xFZ7R1+BjXT3qre9riF9oABIqr6HcdUK1B8862jZYDkJZsd/2HvElrCKY6FgTyx+
         t75NZGfTS6IAbkpLmkT6367MkbWy6+4AgM1Om7aG3jCDwZuiF8tPz0u3FxbRFhKVysz8
         nj7Q==
X-Gm-Message-State: APjAAAUO4LIK2h89udbO3GQV+pUx8iCyv+bbgnJcZYe0stnr3jgAJW5Y
        RIutCHbazO+5Y3vVs7VsgmPZqQ==
X-Google-Smtp-Source: APXvYqzfKLqTly8R2+nDMVxfUG+KWXR3xS9hfzkJraMvIXpnmKxWsB7m7FC37LNAiazfLFw7OxTyig==
X-Received: by 2002:a17:90a:f8f:: with SMTP id 15mr2489698pjz.58.1570548793160;
        Tue, 08 Oct 2019 08:33:13 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a8sm21062501pfa.182.2019.10.08.08.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 08:33:12 -0700 (PDT)
Message-ID: <5d9cac38.1c69fb81.682ec.053a@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1570480662-25252-1-git-send-email-mnalajal@codeaurora.org>
References: <1570480662-25252-1-git-send-email-mnalajal@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Murali Nalajala <mnalajal@codeaurora.org>,
        gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     mnalajal@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH v2] base: soc: Handle custom soc information sysfs entries
User-Agent: alot/0.8.1
Date:   Tue, 08 Oct 2019 08:33:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Murali Nalajala (2019-10-07 13:37:42)
> Soc framework exposed sysfs entries are not sufficient for some
> of the h/w platforms. Currently there is no interface where soc
> drivers can expose further information about their SoCs via soc
> framework. This change address this limitation where clients can
> pass their custom entries as attribute group and soc framework
> would expose them as sysfs properties.
>=20
> Signed-off-by: Murali Nalajala <mnalajal@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

