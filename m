Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D736C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AF4205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dV9hywKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfLPP1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:27:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40759 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbfLPP1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:27:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so7783271wrn.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 07:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lXvZ8ghhfdZ8NPRfLssmgFau0MZh48KQ9J/EcIOsShU=;
        b=dV9hywKHOeNRECRawCoW4x2oIy9lAJvgikf8eMTXx9eeRUUjqzGpP7gYaNfksX1bgX
         KEauVfQJc7nQIUkH6Z4vnsa1InVhf0HSSN3M/obk75hWE0/bptv1MCCZGLI+Khom5DMT
         v/nYFx0ZPLXCJLT8E/qdPT+PwVgz1LfdEHkyjnUKnYelwvlnY4EVrpTsDkdXEZXDRiXi
         brajpgpe9hF4Pht1YjXfbJgJ4N78BU9E/3zwIa3jilB/4fdWMiPG3xi1qen42FonbXty
         RyfkD9OI7JhBcl6fkkSu/OcYd1omHyrQGKDqumuqnKNaDyLwE6PR7VMMlVoZSgyuVL6g
         V5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lXvZ8ghhfdZ8NPRfLssmgFau0MZh48KQ9J/EcIOsShU=;
        b=MQeVeHleM1ydJThOmWYrVzkjuUnzVhLG1B2hmPNzkos59SsyzL9YqSmxF1GiAVwi5j
         dYQgRAYFIU06ZIhsJaUxmWbNmw542u6/Tr7Kej703mGttV6MaYwmiOSfZJIJsQISYUk6
         FFgHSt+dU+WJbAdXqaVS4OQLk5QCidLdBl+qsY/2hnBVfzVRWJxjSFvobyWl+UvrPj+0
         LQg6pIJOjmiGFJvC5lGVLW2dNjAyjpG/l6K6tvr7cXRECjFPvhh083WMgeJOHz7LxTsC
         W6d00WQBX4hML2CkIdJCGN5LpzS5ulNH6uScbqXHcUBQYSiFqHgbCO3dyXhNRgZqfF2o
         6hOw==
X-Gm-Message-State: APjAAAUfClUbMz4BSLemBnksPQEWEVPifKmgRtaQWh30ygThQTCFBmgm
        4rFdxWX7K20Darr/I4USYtnOLw==
X-Google-Smtp-Source: APXvYqwZqxKTkiP7jmfq8woFaWd+xxgjieGkt7i0/yk3u/GkdRltZGG2vJmEQh+Yxh8VpF9Sfhe43A==
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr30710283wrx.153.1576510058170;
        Mon, 16 Dec 2019 07:27:38 -0800 (PST)
Received: from dell ([185.17.149.202])
        by smtp.gmail.com with ESMTPSA id e8sm21849174wrt.7.2019.12.16.07.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 07:27:37 -0800 (PST)
Date:   Mon, 16 Dec 2019 15:27:37 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        stefan@agner.ch, b.galvani@gmail.com, phh@phh.me,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH v4 1/5] dt-bindings: mfd: rn5t618: Document optional
 property interrupts
Message-ID: <20191216152737.GI2369@dell>
References: <20191211215409.32764-1-andreas@kemnade.info>
 <20191211215409.32764-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191211215409.32764-2-andreas@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019, Andreas Kemnade wrote:

> These chips use interrupts for various things like RTC alarm.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v4: add refernce to interrupt binding
> documentation
>  Documentation/devicetree/bindings/mfd/rn5t618.txt | 4 ++++
>  1 file changed, 4 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
