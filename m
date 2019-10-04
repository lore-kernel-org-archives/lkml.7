Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C0AC4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABDC2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AMunfFNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbfJDTpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 15:45:08 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33855 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729586AbfJDTpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 15:45:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id r22so5298082lfm.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 12:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ig2bd75GnHMToY2Lt27CYgTDtNYbuy1gGc25rUD2An4=;
        b=AMunfFNpKE+8jkSxgQ+CmomwXobKVHz4DqW5IBbefEKK+erUajn7p/Qm7dt9Z6mmZH
         0rS++FlqOof4RDzziQob9sz9zzPwzTrhE5GkE/x/F/amWFcehLUSVXRSDjYCdfXwUTW/
         PjBIO1alDROA7ICvUJGxxWOuIDhf6j8kKt13KavYOw2GzeIx7vtMEVZXN2uFx3XibqkS
         Owe1ULicJr+Qh8sKAuDQNjH+SP+37Cj4LnCGNgq0n9LLSGr8c/aILBVaPH98cpusnlLn
         VOfZa4DSPWHoEJ22H301f8oPbFYOUdFDPY7xDoXHuPXgWcApGpW1pmFQuNvVXwu3KYTu
         1lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ig2bd75GnHMToY2Lt27CYgTDtNYbuy1gGc25rUD2An4=;
        b=Z8w14j5WMzKtk/7qkkwZzmieFi5j8SEzFLn1+ceTqGvIJ6xRpFNjBw95CPizL/FlgO
         BSpLm1QiOx6NBQ5acOLCLSDet8Ky3tU/VHSXxSlp7fXiYfgAWKJIUJpT2bgjus7tUy6f
         f872nELaAVc1ndg13Vt/c3+e6H9lw4HKo+k9ynr+IjAOTBuXeY+ByLQCQu5Cr1jqmrqQ
         o+F2Qqw1yo1JuW7r8+06qnzCGGb21VsVwZu4Ec0AMmvyER27NuMCsziZ6Mb9SwHF973q
         eOXYE0ZtuBWdPIbNAn3IPyqYrtOr2Boaxal5oac8UJQDV3x2cw34y600qWkF07ax4jIk
         zZmw==
X-Gm-Message-State: APjAAAX3BPDOcg+UL4Lv+8cHelCiZFGFAnIKPSTx9ELWDBSuZr+MOni5
        j1B82DXf+s1WnMHHJ4Z9sbomjewzziKnAlc5XLkh5w==
X-Google-Smtp-Source: APXvYqyfDJMQJRS/zQ6t2yMjF09Dcf72KV0t+O+BMP8nioJ5Z9vrYI6QxASJCmiz1bsPY3Z4HKU2ONkNeMD7WhAvZho=
X-Received: by 2002:a19:117:: with SMTP id 23mr9983798lfb.115.1570218304825;
 Fri, 04 Oct 2019 12:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <b17404cd-294f-fe2f-e8a3-2218a0dae14f@web.de>
In-Reply-To: <b17404cd-294f-fe2f-e8a3-2218a0dae14f@web.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Oct 2019 21:44:52 +0200
Message-ID: <CACRpkdbgUVm_6MdHw+6MJBc-oHYp-MA7_3jM3buQtKJEtEMtnA@mail.gmail.com>
Subject: Re: [PATCH] sata_gemini: Use devm_platform_ioremap_resource() in gemini_sata_probe()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 8:34 AM Markus Elfring <Markus.Elfring@web.de> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 18 Sep 2019 08:28:09 +0200
>
> Simplify this function implementation by using a known wrapper function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Looks correct.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
