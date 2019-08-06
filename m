Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566E8C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221B520717
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yHCLfXut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733168AbfHFPU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:20:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40445 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732913AbfHFPU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:20:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so88264954wrl.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TYaSujJB8AjUE/mL3dFUGkFVQfhh4XyBtVxfATnPyb8=;
        b=yHCLfXut4OvNYRY6wyJLqdk+LSiDM7gkl1Vg6s3TnqGLupy43mOFw4+QfSCd7318Kr
         l7C5SjScjQQVrKiPhxF593pXO47t87ydTOL0KE+1N/ZfQToUeIez12ew7O8rSCd9XOy2
         AdSTQMw7WoKhAG83ff8kt/RNbFdc4FvvMUtgkkAhXv4PYb7SEG/4vIZQQiiP5UK7+6kS
         uYO8oYetE/5uCKVotWwH2vxMdvM0bICg9/CZww0z0uWvlxrnnpFFhCYUr1agvlo5tgf6
         hbY9Lhl7TGNxMvcFq0FB7oGxsW23TSUz8gbI2S4mn6dEVFJWIuyeCaC4dDuQN8FObb+y
         2/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TYaSujJB8AjUE/mL3dFUGkFVQfhh4XyBtVxfATnPyb8=;
        b=HfBC4qGtCqt89STAE0lsbfYFC90jSzLZCZuThLDn6/md5yVcmdxrmkX4Tuy1h/z4Rj
         3wxSt825yYMW4yEKR+/bUHt+9z++kRhJoqZLRN9ZE293+S7n/zc52ZX7v0A0xYmhTxYJ
         /0pKBJYYAIyr8lk50IhotIHEDWX4zIQm7xCLOo9yscJBM/Ic41UMcTLPeZh6iwptYiS8
         qjVpniUhRmSg3B7Thc6IGd8mUZH1wRc2SmtofGxRyw0gRIhpBozg9ZniYbiwbWjdgt3r
         U0Ura4Nh+9tlMYHRPZiabh6Iy/2Rlji9owa0wof9g3uMHiOaK07OQJFVWH2UrnThVhGv
         5NZA==
X-Gm-Message-State: APjAAAWDLKVdhjgdcfruWhdlrY6sdXdqDaS6xtfw//F0acSaKjPjdEH5
        Fv08rYWI69wR4JlDjAtpKl82Yf46xZwb+g==
X-Google-Smtp-Source: APXvYqyESJpUwM+2vlQpQpC2fNiMFk6tYD0yityn1JVxyS1RsbIz1Wgs325rjrWROHYxrfWW/Z0nYg==
X-Received: by 2002:a5d:4284:: with SMTP id k4mr801849wrq.6.1565104822560;
        Tue, 06 Aug 2019 08:20:22 -0700 (PDT)
Received: from [10.1.3.173] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i12sm101885942wrx.61.2019.08.06.08.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:20:22 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] dt-bindings: display: amlogic,meson-vpu: convert
 to yaml
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amlogic@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190806124416.15561-1-narmstrong@baylibre.com>
 <20190806124416.15561-3-narmstrong@baylibre.com>
 <CAL_JsqKS7KeUBhEn1kxT0HZddOZ6oDaZDStUppSdL2vXfAuccg@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <2c83379c-0857-86da-6f4d-ade728fd5b10@baylibre.com>
Date:   Tue, 6 Aug 2019 17:20:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKS7KeUBhEn1kxT0HZddOZ6oDaZDStUppSdL2vXfAuccg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 06/08/2019 17:08, Rob Herring wrote:
> On Tue, Aug 6, 2019 at 6:44 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Now that we have the DT validation in place, let's convert the device tree
>> bindings for the Amlogic Display Controller over to YAML schemas.
>>
>> The original example has a leftover "dmc" memory cell, that has been
>> removed in the yaml rewrite.
>>
>> The port connection table has been dropped in favor of a description
>> of each port.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  .../bindings/display/amlogic,meson-vpu.txt    | 121 ---------------
>>  .../bindings/display/amlogic,meson-vpu.yaml   | 138 ++++++++++++++++++
>>  2 files changed, 138 insertions(+), 121 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
>>  create mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
> 
>> +  power-domains:
>> +    description: phandle to the associated power domain
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/phandle
> 
> You missed this one.
> 

Indeed, thanks for spotting, I'll resend without it.

Neil
