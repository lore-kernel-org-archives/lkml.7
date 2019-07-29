Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E68AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C297206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfG2MrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 08:47:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38501 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfG2MrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:47:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so24406454edo.5;
        Mon, 29 Jul 2019 05:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3/PzPbZkEB5/N/cLAuzFRUW0qob6QXaQyM+vpTh0XMA=;
        b=SR6fsddqfkFP2vlQfxvtUB4n7ciwqG7XI0C1g1dUkHkNFd/6NYj7WYVddcNMWconG9
         XX1aN7T6GytWo12JrjX5Wxhq8JfDgsFdTCgBEsJnFb1WLdJxxlsovA0456eVPBVqfhbe
         RLOTzexTrOjHaSYPV5/IRBXXJorDCjODEfC2C4fpDHx66iKvXM9n5qpBar5+AbC06M9J
         2cLJ9gbwDDSS3S0jNxx6MSblK5zpmv8AHzSMS8KpRqVebKCm6MKLCaO1ygUd8MlvMXXt
         zhmUV3X/HFaE817tdt01V4ZuU3YpCr1SE61CVarowowbs4QFPRfsBkS1MzaaLfRW5Rje
         +MZQ==
X-Gm-Message-State: APjAAAUoI2tMFuMeIcSma4Gx0v3GmsDpt+CdVVt88DnfL6F8dDtYjPrz
        kgVlmPEf4ITBKPlnMWSntbzEdx0FaU0=
X-Google-Smtp-Source: APXvYqwLtIdFpDiJiStZ5SRASFMXor63A75/giBun54t56BFNcyVhaVUFQn77zhDuOua4E6nNuBXsg==
X-Received: by 2002:a50:f05a:: with SMTP id u26mr96123281edl.116.1564404426839;
        Mon, 29 Jul 2019 05:47:06 -0700 (PDT)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
        by smtp.gmail.com with ESMTPSA id p23sm11473636ejl.43.2019.07.29.05.47.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 05:47:06 -0700 (PDT)
Reply-To: efremov@linux.com
Subject: Re: [PATCH v2] modpost: check for static EXPORT_SYMBOL* functions
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190714152817.24693-1-efremov@linux.com>
 <20190729092250.32670-1-efremov@linux.com>
 <20190729222045.4b491ffb@canb.auug.org.au>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <2b6fc296-bf42-f99d-e420-3293471db033@linux.com>
Date:   Mon, 29 Jul 2019 15:47:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729222045.4b491ffb@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/19 3:20 PM, Stephen Rothwell wrote:
> Hi Denis,
> 
> Just a small note (nit? :-)):
> 
> On Mon, 29 Jul 2019 12:22:50 +0300 Denis Efremov <efremov@linux.com> wrote:
>>
>> +			if (s->is_static)
>> +				warn("\"%s\" [%s] is the static %s\n",
> 
> This read a little wrong to me, maybe "is a static"?
> 

Thank you! I will fix this in v3 in an hour.

Denis
