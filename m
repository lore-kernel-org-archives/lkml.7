Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BEEC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6D3207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r186Ngrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfLPIiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 03:38:18 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46431 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLPIiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:38:18 -0500
Received: by mail-ua1-f66.google.com with SMTP id l6so1304604uap.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 00:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OP2XiHV+z9XRmOc6CVIQd7a0qzdvr1/Q3scZZYxr1/c=;
        b=r186NgrdfTPHE2tpoPDJa7x9tQuQ/QFHgodakc61Ob+nFNnXNgovHI3f1/7CUBT/1v
         4wcw0kUA9wCRMKc6fuAe+RcZzpp3T5EIzlUrObzeRWgYp5L0/dyQfTt8+/apH0TPJ7Oc
         2gVCCjJ9L61hrUgACxE7Gx2t7WFaRzRM7IpiJWo+wTfIg292hispYmrOsZzsBvoLMNfF
         Ir+O1OpLqiEbXITQT6ito6EowgfIVcrr5s8cMA7qBowJYvBKBKvicFeL2es39Dvv6J+2
         aYXnn6xwZg35oIC5h21qC/j/dgwQFtPSlC2JSprHr5rDSXU9LNIuIsQCUbktM0XaS5j7
         bo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OP2XiHV+z9XRmOc6CVIQd7a0qzdvr1/Q3scZZYxr1/c=;
        b=IKa4ngQMcp5ahcoFaucAnSrdTy6RX2xmmXLRrTGl+0WU753ksa4YsCefax0LrXe2Y0
         eGg56pCn+E+YCKR9Vcums3FegBaarqJdlhg9GIuN9sQeHtGMw8OUekFWEOxX8w0yoNzG
         /S68F6HmDwkTC2eW6pdi/R8nV25wcMalTOQ7TrX0gZIW7FKKFEYV1vxL7rE5gamw1Qbk
         8d5w84TKC3LeQbunOaPwru2YA9+hXNT+plHR22UqBg/mDu8hPPUDEprNy/El68jXqOfZ
         Azi4/lvr54BVBRgSLLBMnrzTaCESaeXlMHGk2X4S6BBhY9CM42M2X31WFadI4BwSoQgE
         UsWQ==
X-Gm-Message-State: APjAAAVucLKPSc2PJK4NmjlEJTPC0YFFXCSOMsZZ7C6YTr5pmDGT6Q2G
        RAceaB+cUHGmaVMRPVRY8BX8GQLAqKYVNkLYcZ07qA==
X-Google-Smtp-Source: APXvYqxWyOGptlYcgZ8GG7DRjA0eoZhkshCQNRcbI8e/5CoIydNXg1zYY8yTVFSvvZjiGUSUFzsofLus8fU624q0t2I=
X-Received: by 2002:ab0:5512:: with SMTP id t18mr22644336uaa.128.1576485497137;
 Mon, 16 Dec 2019 00:38:17 -0800 (PST)
MIME-Version: 1.0
References: <0101016ef36a5c54-2907cf32-2269-4a8c-9447-b086e7c86d98-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016ef36a5c54-2907cf32-2269-4a8c-9447-b086e7c86d98-000000@us-west-2.amazonses.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Dec 2019 09:38:06 +0100
Message-ID: <CACRpkdY9ETQRHn7x2D2XVLZ810Uo1cPQxMBqTy5LnrORRNjTVw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: Add new qup functions
 for sc7180
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 6:24 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:

> Add new qup functions for qup02/04/11 and qup13 wherein multiple
> functions (for i2c and uart) share the same pin. This allows users
> to identify which specific qup function for the instance one needs
> to use for the pin.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

Patch applied for v5.6 with the ACKs.

Yours,
Linus Walleij
