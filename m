Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADD6CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEB321721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Eu9IYt8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387526AbfJ1UfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 16:35:05 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44892 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfJ1UfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 16:35:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id z22so16608845qtq.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 13:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Efo1f2iDzab89yA+sJpBeMa4JpkP53h4aTWIEfY85cw=;
        b=Eu9IYt8xgViRRDFospaBzlKHKIoMfhwnphLpwIqOcmKo2agUDJr/zHMu8wRo68Ublf
         w5GMHe845cJ+eqjWt7mRm6i62gpdef1Ru769ylnIMSegRQFNLUMdlaF9wKKSYo5dpnBn
         6xKa4YxCnQGwOic42Kk4PReQomaWv/Ms1fstk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Efo1f2iDzab89yA+sJpBeMa4JpkP53h4aTWIEfY85cw=;
        b=tNEKlDrT5frpHrilkao+n7HN6pdgsddXWAZT+mgVlqMyMnnH8BYonZBVmG6DNvrbdX
         CDwQPfe2uFlBv2Gymr2HD7qt6hrFLaXddj4OdIgNzKr1LgLgSxGW9kSFvALVJwFtb/wW
         LwzBU+mLrtR2NzagUraf7fk/KIe3bZoSV39yU3vIXxrTiW2rIPi/KeJl401sFtrSLijc
         kQNRF/qkeUhOU8Iee88n/QO63Q0B6MhNoj8wBEceVP77WYW9VXVA5I+nfpECx7Jd2uJH
         iaKYZNy7z3pN/zUeTaKuMGegyHx907adZg7RUAFniXijofPM1+UUmgj3+aDf2RPqZ9nr
         JXQw==
X-Gm-Message-State: APjAAAWafF/YM35CeR8+Ey0K34BABq3qae2nWBWXSYMyWbg21SFGeb2a
        arZw83ft5NMsnq3wKRFZdvq5t8p1TYCzLzwmdjp/JHIX
X-Google-Smtp-Source: APXvYqzfEPeXa4QdRhsiRy5Tut2ccCFAItNf8EJ8CfRyeLcnV0fDD5WDT7hc7+RIs2GMd0jwy8QnAj1es5BG1hfnV9I=
X-Received: by 2002:a0c:8a2d:: with SMTP id 42mr11719339qvt.117.1572294902863;
 Mon, 28 Oct 2019 13:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191028201634.GA29069@saurav>
In-Reply-To: <20191028201634.GA29069@saurav>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Mon, 28 Oct 2019 13:34:51 -0700
Message-ID: <CACKFLimJZ0YXGCEBaurUyeWrq1kgUUdL7QQWMVJvMEkWZukgPA@mail.gmail.com>
Subject: Re: [PATCH] broadcom: bnxt: Fix use true/false for bool
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        saurav.girepunje@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 1:16 PM Saurav Girepunje
<saurav.girepunje@gmail.com> wrote:
>
> Use true/false for bool type in bnxt_timer function.
>
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>

Acked-by: Michael Chan <michael.chan@broadcom.com>
