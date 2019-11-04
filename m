Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52386CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7A2205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="fKyAoSLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfKDHiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 02:38:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37977 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfKDHiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 02:38:46 -0500
Received: by mail-lj1-f196.google.com with SMTP id v8so758068ljh.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 23:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Skx+IlvEjbz4Ey3Z8Es5BpI/gDpf4xIU9seBvakWE2o=;
        b=fKyAoSLbBB7K6Hwz7WQ1hkLB8UolD91873nvpgYDwu3vHgk9FskSurtOXN9GkL1c/5
         O1QO4r/LPsSNuj4aQkwxPg2auKprW4F4lCLH/I6JsLtqOEwdNwfRS8W2sWECsVQqK6CO
         JdWAYkhmIGvDXKDiJ6rIDpzfpG3P7N4TPq36U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Skx+IlvEjbz4Ey3Z8Es5BpI/gDpf4xIU9seBvakWE2o=;
        b=ETiUoU/PB8QhZljPE34CBYJ9TeBRbDi1OddRebY4Do8Y8Qz9OGObty7iVGNJfIBwoA
         ZxG3tKBCZXqivU3RXHM+gbmAj8slhKG/t8kA1z7g9ZFYatYnRkRvgpgV1DM5ahg5nJdK
         TFvp4YLurpeUPjVIbboNa9bPtwYAC8xLooH7DKIoxIl2vVlIeGIrsYviPiBXEVEZ6f0z
         kXGb6e+EMILYVTJ/LNg3cCJN/gzLkk+oiX0kG10/Z7VEoXr3ThVVlJelYBx8oUiQ0EEg
         M5N2S1KSExxFfzS6IYcheI+382wCWhyusxSEatgkVoKMIH2+uWxFMVONiZjARx7saYFz
         ZIOA==
X-Gm-Message-State: APjAAAX0sWBU26bQg4dm8zAY/JTYSjqV2gbYDRKX3HY2FKzsN0nKimMQ
        UR8Tu+wxjJobWY1mXsQof5Wbyw==
X-Google-Smtp-Source: APXvYqy0dojhXdV/Wyv7nl7DnnJ1xyl+IlR4kyBZvriN/BA2WM6WGs9kvJj6pwDEOoKIklqLOYQZtg==
X-Received: by 2002:a2e:5d1:: with SMTP id 200mr18228489ljf.50.1572853123654;
        Sun, 03 Nov 2019 23:38:43 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id c5sm6344575ljd.57.2019.11.03.23.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Nov 2019 23:38:42 -0800 (PST)
Subject: Re: [PATCH v3 28/36] serial: ucc_uart: explicitly include
 soc/fsl/cpm.h
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, linux-serial@vger.kernel.org
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-29-linux@rasmusvillemoes.dk>
 <a921b57b-04d5-4874-89e2-df29dfe99bfc@c-s.fr>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0acb2e96-3485-5e49-bed1-8deb2051cb91@rasmusvillemoes.dk>
Date:   Mon, 4 Nov 2019 08:38:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a921b57b-04d5-4874-89e2-df29dfe99bfc@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2019 17.19, Christophe Leroy wrote:
> Le 01/11/2019 à 13:42, Rasmus Villemoes a écrit :
>> This driver uses #defines from soc/fsl/cpm.h, so instead of relying on
>> some other header pulling that in, do that explicitly. This is
>> preparation for allowing this driver to build on ARM.
>>
> 
> UCC are only on QE.
> CPM has SCCs. instead.
> So this driver shouldn't need cpm.h

But it does. At the very least for the BD_SC_* defines, possibly others
things. It's possible one could split off the common part to a separate
header, but that sort of cleanup/refactoring is beyond what I'd be
comfortable including in this series.

Rasmus
