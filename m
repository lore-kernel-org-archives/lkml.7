Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7345DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4251820685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w/Hb5GBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfDWIsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:48:00 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33735 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfDWIr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:47:59 -0400
Received: by mail-lf1-f66.google.com with SMTP id j11so11089228lfm.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 01:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2oxM6m5LlrRbJWAsU6VB0Zovu7lyror5LQ3rlFL6M7A=;
        b=w/Hb5GBdjdAyoYRoi6j4dEobJaCtzCW1lIWBqJCzT1u5aEzYXDrC/Nf1zAkhD2tUBl
         Ndd7AA0eWS+6x9uGQuHTUo/hPLZETKBTHyG6z7KEvnMASjWDTBANRNspsgG0ZqlAZALi
         OLwROgDIZSotkhDo9VYWOdGBFD2130rdu4OupOB9crWbEMyVgoYTmziH1GqFtB7Tw8v9
         6nw/pblHuW0zNzmt7ik6cW0XM2DGayogkkB960rkwrhotn6I2tacXqOWGbG6GuUlxO35
         PYCLpu8jxViOs5GAP2J6jSVbAjS9pzyjvm2Aqm82/+ONi501jgsabbDo6hkkcMP8U1NK
         bsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2oxM6m5LlrRbJWAsU6VB0Zovu7lyror5LQ3rlFL6M7A=;
        b=t6szPVe77Yct/R4GpfybkARza6vue60Ti5Cqb3FvyhZI6RR/5hpkMI35BPk8M7e888
         RXFB1oiAqnBx8yutyrbuEE/jIc/Ox0DWxERvV8C5BLnNRqDBREflr1orRaolLPMyNodV
         xmhR1tjZm7kVqQ0/OZXoGqlmmMitWGEVfoZddAlQygLowyEAv5ynIgOa+mB4VLi3Qgbh
         coDfBkCRZbA8ScHepbryPZiKVwCKIXaw4NrcDsrTo7L1EOIV9fjVtmqdqmOHiMANTFzN
         5a1HNtzSSOIBb+9jAGIp1cnhl17w1x9ZxNMbFFvjtRrCVmZ+Jrj4Aad9T/pzbFE9PN4C
         gT3g==
X-Gm-Message-State: APjAAAV+jaMRVJ5fvypqrCl22cBt2f8aBv/jd+ukKhc1RnFDBPz8Ijw+
        I9LNnTDWF34FcNftY21STDiG6zfKpZ/fLZJhhoo8qg==
X-Google-Smtp-Source: APXvYqzUOCuEeEtUGAim0jDA4allqWRpFfifZX12jU69kEJJ8kkKJqxvy2XBiwD4rYN+x8Vkl9kT4/4++zRcsMx96g4=
X-Received: by 2002:a19:761a:: with SMTP id c26mr12966059lff.8.1556009276926;
 Tue, 23 Apr 2019 01:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <1554895824-25709-1-git-send-email-alexandre.torgue@st.com>
In-Reply-To: <1554895824-25709-1-git-send-email-alexandre.torgue@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 10:47:45 +0200
Message-ID: <CACRpkdbRgyfVAZ8taoDAZo+QHYYvzOo3mZC4fosxyz0-X37y0Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add pin package management on STM32P157
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 1:31 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:

> The series adds support of chip packages for STM32MP157 SOC.

Patches 1-4 applied to the pin control tree.
Sorry for slowness :(

Yours,
Linus Walleij
