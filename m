Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CF5C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E351F2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbfFTMQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 08:16:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54404 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfFTMQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 08:16:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id g135so2838164wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 05:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B9TrtGyucT7ajjWuvboh+Hy5dvZksEd6/p4CR2fghIg=;
        b=A7OSdNT+3bcSy1ZMZkS3doXRRWmpmYpQeUp4St2vBpbna8fSIVmsIS9lt3WYKmo/lg
         EzqpP4JIPR+rDBwn9eIdfa+SHiOKztBxJTL+qk/5VKA61zYADlRMNjSmLBVDdYUJMUJW
         hR3Ab56kzX7q/jSBDFCLr+akM0jJT6uJUX1g/n9LQcS7ApENETP6hiGMkvpLvOnxxHhF
         aKEQkfHaScVzOcCnMBweJBXO/tLULzPh204es0YFpM5r6Doo03PJOat7njbaSWfwIgYq
         GuTn8myiIsNyCac1W5vhxEb/GzA1l4MdyBTH0TvXlhNZ7cPLIwP7U8IreDMcDNfBdUDY
         BP5A==
X-Gm-Message-State: APjAAAWmsRlflUz647COptG6tYWdaOUpP3dH5VJp2SJOjOKxkFEf5uil
        CTrn//BWEMcoD6YKVsPgfc2H6A==
X-Google-Smtp-Source: APXvYqzkWL+juoCKmAeAkp5CGN3y2wmBiY61EVn/WFlS6StZw7pwdzH2GmRBNiiSmutGjpGYKskLFA==
X-Received: by 2002:a1c:4484:: with SMTP id r126mr2782080wma.27.1561032984421;
        Thu, 20 Jun 2019 05:16:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7822:aa18:a9d8:39ab? ([2001:b07:6468:f312:7822:aa18:a9d8:39ab])
        by smtp.gmail.com with ESMTPSA id d18sm36464286wrb.90.2019.06.20.05.16.23
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 05:16:23 -0700 (PDT)
Subject: Re: [PATCH RFC] kvm: x86: Expose AVX512_BF16 feature to guest
To:     Jing Liu <jing2.liu@linux.intel.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jing2.liu@intel.com
References: <1561029712-11848-1-git-send-email-jing2.liu@linux.intel.com>
 <1561029712-11848-2-git-send-email-jing2.liu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fd861e94-3ea5-3976-9855-05375f869f00@redhat.com>
Date:   Thu, 20 Jun 2019 14:16:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1561029712-11848-2-git-send-email-jing2.liu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/19 13:21, Jing Liu wrote:
> +		for (i = 1; i <= times; i++) {
> +			if (*nent >= maxnent)
> +				goto out;
> +			do_cpuid_1_ent(&entry[i], function, i);
> +			entry[i].eax &= F(AVX512_BF16);
> +			entry[i].ebx = 0;
> +			entry[i].ecx = 0;
> +			entry[i].edx = 0;
> +			entry[i].flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> +			++*nent;

This woud be wrong for i > 1, so instead make this

	if (entry->eax >= 1)

and define F(AVX512_BF16) as a new constant kvm_cpuid_7_1_eax_features.

Paolo
