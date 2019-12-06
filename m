Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F9DC2D0BF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DE82077B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575594456;
	bh=HwUu5g36bag1v0XboNCCUQ5GK4sKKKlMNxJY7I9JECc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=k+gfmgdi+wd1vgN+xwBlU6eTIj/h3kFw8B55HPk1n1ROVfTK6J9Bud+sFgAGnmYJU
	 qDQQqbOtac+m+iKorPl1PKgZpkDjqX4W/0KIRmS7HTX961ImxzfzT5WrR89QYxKYGx
	 tuPnrU8qYJ3RvJ8qXetiHSA/LI/FXJkhYftfR+is=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfLFBHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 20:07:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfLFBHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 20:07:34 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 637B42464E;
        Fri,  6 Dec 2019 01:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575594453;
        bh=HwUu5g36bag1v0XboNCCUQ5GK4sKKKlMNxJY7I9JECc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FskL08BAl+2bxG6lq95wSu0/exiTKmXfUsfbc1MxUTAnRUBys6dfp8gzxEj3C9pRH
         KL5X7p1z1TPhAooudGgG2cduAWzxXu5atr8eJmCkniV4zMw6ye72VV/wnsfd5VW23A
         p8BwmSdW+IE4C++9iJqyQhNHmOVsus65R5MrI1vA=
Received: by mail-qt1-f181.google.com with SMTP id k11so5518415qtm.3;
        Thu, 05 Dec 2019 17:07:33 -0800 (PST)
X-Gm-Message-State: APjAAAUMvgECDkQo1puc7kAJWxjaj6QLT3DAPvzVfMG7mZ9tHdM0MJBZ
        9GehepqUVS1v3i9PnEOdnApGkspmFrIijmFg+w==
X-Google-Smtp-Source: APXvYqxz5YznfBQRQCXWy1g/IVPDLnFCTW2XZwhHVCjGfjltAnp0vF3SAPsx60BaTeJpVY3mKBA0PlnSAHQ/YO0m1xY=
X-Received: by 2002:ac8:7357:: with SMTP id q23mr10742556qtp.110.1575594452529;
 Thu, 05 Dec 2019 17:07:32 -0800 (PST)
MIME-Version: 1.0
References: <20191205232411.21492-1-wrightj@linux.vnet.ibm.com> <20191205232411.21492-2-wrightj@linux.vnet.ibm.com>
In-Reply-To: <20191205232411.21492-2-wrightj@linux.vnet.ibm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 5 Dec 2019 19:07:20 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+3uOdOnFYAmwX+B-Bp=97poef27CTD39my8o_vm8B4zg@mail.gmail.com>
Message-ID: <CAL_Jsq+3uOdOnFYAmwX+B-Bp=97poef27CTD39my8o_vm8B4zg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon/pmbus: Add ti,ucd90320 power sequencer
To:     Jim Wright <wrightj@linux.vnet.ibm.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 5:25 PM Jim Wright <wrightj@linux.vnet.ibm.com> wrote:
>
> Document the UCD90320 device tree binding.
>
> Signed-off-by: Jim Wright <wrightj@linux.vnet.ibm.com>
>
> ---
> Changes since v1:
> - Replace .txt file version with YAML schema.
> ---
>  .../bindings/hwmon/pmbus/ti,ucd90320.yaml     | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
