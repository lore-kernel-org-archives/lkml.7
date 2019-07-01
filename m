Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DA6C06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A252146F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="e77hRdek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfGASWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 14:22:15 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45115 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfGASWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:22:14 -0400
Received: by mail-lf1-f68.google.com with SMTP id u10so9415192lfm.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 11:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lSeGwgb7OCHIZ0lDpAKilpMUUcD2EKTAejOKK6LikFQ=;
        b=e77hRdekb5Ksd1Rsj0fXd4QUcYSQWip33lsHjZwlobtp8hSu+bdm8BuUoQZg2SmIuJ
         HcgNgRizUQQRYmcssGQ0o5S8HyGblr9QKslVYYOZYOWRleFBchsDhgMg6/uztcIKPHyD
         Zrqsxt2BdK9G6bp0t5QftvWtOn650n+KpKpZtRUrmueqjheTJ+yOQqxddQGG4Z/60lKF
         45EIuSgi3v65Olqm0cCe4f3EkrSXZ+BedxDj4YNnubY8xsSOhrSrBw916twRg8mw7pt0
         ppKZCyVm1FZ9ojqssfg/Lup17kvQnUIdyqzVF+2oT3ZB4rQUK9TvIhbX4HarDNW+6t/D
         duYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lSeGwgb7OCHIZ0lDpAKilpMUUcD2EKTAejOKK6LikFQ=;
        b=fUE2xSeDlMAqDrOd21ROGrCqj5LinuJ0hqG7VH1crmkMwj6cP1i2ThY2WozE2aXJef
         86sS/fin+HfX5DKqlAywv3cEXWeppLPJTBJNDG5VQb5OoJfIVQN9RdGOVvrztoUZB1as
         nDwMlFg3q4BrAOIHntuTBG/VLHi43x94VghWc6K0GB4WINJtYyfCbVAmWHRhQOHOAZNr
         hBMU3Auc0ceA9U0xFWWkoIaOmZtgcst9F5tAUTrgXu/8o48GuPrtt3wXTFLxs6U2ly9q
         y2ZF80KyKoXa2mSk+Vbifu03rQf0Se6w+vVgSqYFQksMdQ/jU2t+2G3T4eibojhrfAfi
         n9Ww==
X-Gm-Message-State: APjAAAX6/HDJc/ko2GvohNaYUjofg2Dkh77Ya7rDv0DZ6nd2uOave4OQ
        3aTdYytXnaJma3cp1Xb8P0Vr51idP5I=
X-Google-Smtp-Source: APXvYqyfow0Cz9tRTvKd2g5VEUBaB2/RuakhGwviPW+ATrJ/ednC/dTkBxSiPl5lPrmuWhtNA+nY8Q==
X-Received: by 2002:ac2:482d:: with SMTP id 13mr12078669lft.132.1562005332513;
        Mon, 01 Jul 2019 11:22:12 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:87f:4d67:ad95:f728:cfaa:94d0])
        by smtp.gmail.com with ESMTPSA id p15sm3440617lji.80.2019.07.01.11.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 11:22:11 -0700 (PDT)
Subject: Re: [PATCH] USB: gadget: function: fix issue Unneeded variable:
 "value"
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190701182031.GA10455@hari-Inspiron-1545>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <746df16a-0e8d-bae7-36ff-5827610dfd99@cogentembedded.com>
Date:   Mon, 1 Jul 2019 21:22:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190701182031.GA10455@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 07/01/2019 09:20 PM, Hariprasad Kelam wrote:

> fix below issue reported by coccicheck
> drivers/usb/gadget/function/f_eem.c:169:7-12: Unneeded variable:
> "value". Return "- EOPNOTSUPP" on line 179
> 
> We can not change return type of eem_setup as its registed with callback

   Registered.

> function
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
[...]

MBR, Sergei

