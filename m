Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F05C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1672F2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EO7ChWYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfEFPLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:11:40 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33955 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfEFPLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:11:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id v18so7220536lfi.1;
        Mon, 06 May 2019 08:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3n8DB0gQwJicPY+O/w22a7ewwEDUX9hB2LtejHOoNts=;
        b=EO7ChWYsyrakC76AmReTFv00un3dIoEiTYk+qJhQMzSoqijYHKzXWuCJ0I0/VU5+S8
         WCnjKlHFzlziDSMNgOzSqKrJJGfa3uTmljF6dAGFDmaPbA55EH3n8aKu2IIHoAFAuMmG
         a3Mr+XOjgvi+w8w4UBryQEXVVV+LqcPovPz59VSYG0uI4APCFnbHIYmkF6FtivdqaB1e
         NjNmVGEpJn8QGiNNiFe5xdSXAJs3el23/a3uvA0X/R7m+IJGGJv+ZkOcHdOIdCW9zLnV
         JnQN4fv0vXOUpC//Uh3srp6E2xGbDxgcfsD77JMk2WCiSFIUqTXoah9mtf5wKUn8Qmu2
         sbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3n8DB0gQwJicPY+O/w22a7ewwEDUX9hB2LtejHOoNts=;
        b=TfLrbUqgo2E02DUR1vwEl0lM/vAaU510j/mPf+54Xn6gWn97XNrSgBcmJBeL3ZdS4Q
         O5Wwv4mB45OCzLXpAJbzb7VJJ6/N+GtGmWtX/ryEpva/VFH555TgEjCpV4eqFOO7pg22
         nx4+hi4FIuOKcLH1nMP+m0dBpCas0hEwmKygaOXtBsxhB4awPI440A38A+3rK8iQtq+V
         yAqkGlBswmYwdwDTCrs/8F3w5pVD9N9D9ts+4veEFII1DUWt+0qhYJUq0QawuIJSszo9
         +gk/dJsqvdjiORBR//alpIP0Su8rS0Rfcj7gMJ6k4jpQfvz8GUowbSITpclSfSxBFnLQ
         CwZg==
X-Gm-Message-State: APjAAAXPG318iLIFaxw7SAkT7bpNqs7D4KhdrT5uoqhMljw68dFznFKv
        mgfY+aXMDHCTbvd3ojasJ24+fwi87Tr4UDMF2MKTQQln
X-Google-Smtp-Source: APXvYqyQGsKPS9Hdd59Ha7rPHw1HVuuhjHYyGU+XfzoaZ3HVWK85YhYX+8My/y5uNGX2MbxZeqyZlipR/byBJ4J/xt4=
X-Received: by 2002:ac2:434a:: with SMTP id o10mr2019737lfl.122.1557155497459;
 Mon, 06 May 2019 08:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190506140830.25376-1-angus@akkea.ca> <20190506140830.25376-4-angus@akkea.ca>
In-Reply-To: <20190506140830.25376-4-angus@akkea.ca>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 6 May 2019 12:11:41 -0300
Message-ID: <CAOMZO5C6XQUWBi39jKeVJg3Jj6auB0mF3h8bWMYZ_prXwgc9Fg@mail.gmail.com>
Subject: Re: [PATCH 3/3] usb: typec: tcpm: Clear the fault status register
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angus,

On Mon, May 6, 2019 at 11:10 AM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> If the fault status register doesn't get cleared then
> the ptn5110 interrupt gets stuck on. As the fault register gets
> set everytime the ptn5110 powers on the interrupt is always stuck.
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

Since this is a bug fix, I would suggest adding a Fixes tag and Cc
stable if appropriate.

I would also put this patch as the first one in the series, so that it
can be easily applied to older stable trees.
