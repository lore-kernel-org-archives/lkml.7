Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EFDC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D81920692
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lv802009"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388826AbfIMT4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 15:56:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33499 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730847AbfIMT4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 15:56:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id a22so28258294ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 12:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YangW0nZxTvuxMasR2T71zvAAP15OctV2hgPwvy27lg=;
        b=Lv802009QJLjWjD4UFEK/0Dz70rSsQfJEfZlJop0qI82z5JcfLHl/2r2yyVgEryl7W
         1V7VB3t+6OehDmsN2DQE6ni7NaHcNp2Qjk+v7bOHqiHHSz/ZfSd5aH8FGktHFz/WpMz/
         D8RTy+RrxlShPKtX937BcbB6hfALtCl/w/SIvP1D5hP+Ix7kQz7pUK9Ag6Bd/qsGEfY5
         KhFEStm+Ybxo1UKqlwTX0KMQD9eMED1Y042cfErh2l0YgwbTnPYwD9nVFRq3Gzh+TfHO
         fqaWvWl9PsK0qoDo6vcQ6e0OPQ13DFgLWXPo9HATYldmlKn3Y8H/flKflvJiDhZuxMkB
         e/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YangW0nZxTvuxMasR2T71zvAAP15OctV2hgPwvy27lg=;
        b=sP7UvN76MKT9sj44neNXIQc66Tq64zv8ZdObTiyWcAqPxdL06YCim0kCuRxPIPCvZX
         t2HCe7SBKUMKWmrfCEB7FkH64XLOkK+PoWqFHqmB7tc+oYDCNK5IBknez5bKBr0gkbO+
         PKYtkpXSTAlhi8VpbP0ZXy1F6doDBK+Oruft8CEnG78Hk4RDvPSekS1kOLQYfoIkGM2X
         gr8kPdNfu1jYyTh1ItPQtRsMyCS0GxsH54FZI3HzXtu3yAKLfWipLJQXR4pujGScQLYe
         OyL5ZdKwMUhDANwhZRB+XsOFYSDWqrMhnQt4Mlawdw0spWc72i/gaoC5kceQCNlV7oVQ
         3KDw==
X-Gm-Message-State: APjAAAXWwyKq9XmLJVU+L0Oa9fSZfm1TZoAzjol/rDeW8yZ/XzcgoEMG
        1AwlsAlnO/CTsqD1TQ3GViAOQA==
X-Google-Smtp-Source: APXvYqxU70mxnPTmi2ptT3akvixZSFIEhcR1gb+O4j9tliEriL3aAlVfx0PwNFAE3sW28jupZdNinA==
X-Received: by 2002:a2e:7801:: with SMTP id t1mr16881585ljc.140.1568404576977;
        Fri, 13 Sep 2019 12:56:16 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id p8sm6581687ljn.93.2019.09.13.12.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Sep 2019 12:56:16 -0700 (PDT)
Date:   Fri, 13 Sep 2019 22:56:14 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH bpf-next 01/11] samples: bpf: makefile: fix HDR_PROBE
 "echo"
Message-ID: <20190913195612.GA26724@khorivan>
Mail-Followup-To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
 <20190910103830.20794-2-ivan.khoronzhuk@linaro.org>
 <55803f7e-a971-d71a-fcc2-76ae1cf813bf@cogentembedded.com>
 <20190910145359.GD3053@khorivan>
 <4251fe86-ccc7-f1ce-e954-2d488d2a95a9@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4251fe86-ccc7-f1ce-e954-2d488d2a95a9@cogentembedded.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 02:02:11PM +0300, Sergei Shtylyov wrote:
>On 10.09.2019 17:54, Ivan Khoronzhuk wrote:
>
>>>Hello!
>>>
>>>On 10.09.2019 13:38, Ivan Khoronzhuk wrote:
>>>
>>>>echo should be replaced on echo -e to handle \n correctly, but instead,
>>>
>>> s/on/with/?
>>s/echo/printf/ instead of s/echo/echo -e/
>
>   I only pointed that 'on' is incorrect there. You replace something 
>/with/ something other...
>
>>
>>printf looks better.
>>
>>>
>>>>replace it on printf as some systems can't handle echo -e.
>>>
>>>  Likewise?
>
>   Same grammatical mistake.
Oh, will correct it next v.


-- 
Regards,
Ivan Khoronzhuk
