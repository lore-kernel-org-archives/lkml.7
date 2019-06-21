Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1F1C48BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BDE206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561127489;
	bh=6Y0fFj3wNgB6evAG5+hEEThOfwgXc810fHqAa8tcPQU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zYb/5ObXtsNMRhjKYSY6dMvGz4X7XR1pqIBf2tWypAH8A8fvqcjcogK8ka0HZ/Egz
	 oHuHrOPilLpl52bmjnDw//R8an5SMehd7WMMwS5Qwi3YBeQBxOhI1Gr3oHJsZjMtG6
	 ppN631Hyx+R4LgBV96zUZ0yPaaqbL2A4quAGouq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfFUOb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:31:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbfFUOb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:31:27 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB739208C3;
        Fri, 21 Jun 2019 14:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561127486;
        bh=6Y0fFj3wNgB6evAG5+hEEThOfwgXc810fHqAa8tcPQU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H2tOXqJ6TINLrZTvx/eNjHML0+blxFd0LoQFe/RGCWk2r+5gPisgUcOI2JJrzl9Z/
         wCRgNbQGfzAvkgQw129veG7MGjnA+Eui7D8xTQerLjfAAhQmLnJmj4xr4b2Z7Pfac5
         q/Y6r0njv+z4wtfqA+xFccY7hUdu5C1cNhlgcYsQ=
Received: by mail-qk1-f169.google.com with SMTP id l128so4561219qke.2;
        Fri, 21 Jun 2019 07:31:26 -0700 (PDT)
X-Gm-Message-State: APjAAAVzUfqWdNuf7Kf3Whi9Tmuqs/4jCrfXlRRoqbUrP7AWmQTYKhtH
        70N9E8dxF0EbBK+mr3b5cA6XlubUHMlcH+yhTw==
X-Google-Smtp-Source: APXvYqxjUHWcRHOr8UxMSaUAXIxs2pGOijqyvXBq6LTF9gNlsVhsS95Y3V+zuGs9IJdIKHSTJzrV7xxlSXEjwJcO8uw=
X-Received: by 2002:a37:6357:: with SMTP id x84mr5759194qkb.393.1561127486015;
 Fri, 21 Jun 2019 07:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190621121344.24917-1-mircea.caprioru@analog.com> <20190621121344.24917-4-mircea.caprioru@analog.com>
In-Reply-To: <20190621121344.24917-4-mircea.caprioru@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 21 Jun 2019 08:31:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLOMKQExp1Vu0Xo32Wx-ETdQk=AWSnex-GQ3QbzdZ7zQA@mail.gmail.com>
Message-ID: <CAL_JsqLOMKQExp1Vu0Xo32Wx-ETdQk=AWSnex-GQ3QbzdZ7zQA@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] dt-bindings: iio: adc: Convert ad7124
 documentation to YAML
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 6:15 AM Mircea Caprioru
<mircea.caprioru@analog.com> wrote:
>
> Convert AD7124 bindings documentation to YAML format.
>
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> ---
>
> Changelog v2:
> - modified SPDX license to GPL-2.0 OR BSD-2-Clause
> - added regex for a range from 0 to 15
> - added minimum and maximum constraints for reg property
> - set type and range of values for adi,reference-select property
> - used items for diff-channels property
> - set bipolar, adi,buffered-positive and negative to type: boolean
>
>  .../bindings/iio/adc/adi,ad7124.yaml          | 155 ++++++++++++++++++
>  1 file changed, 155 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
