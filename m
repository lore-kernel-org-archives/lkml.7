Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE38ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF382133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbfJIJBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:01:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfJIJBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:01:21 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5919D51EFE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 09:01:21 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id o8so749351wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 02:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=THMxQozkuZcvJWHmfL9vI/wdlPo7narpF+xJ9DGd+Vo=;
        b=cQGkZ3vUdXZ7cLS3nR+MtQyTpdim6xCDERoWhLXm2I2fUyDLdeR3n44Q08vxTbVqC/
         DhjefZt31AgjEsTf0hBXKfgpN81BhyP3MNiPDn7zzFVQkUIlMOavCSEhAYIbOkejzxfL
         TazRaJ6uSksfmL15y2AS7+Xg0Tn6rZH4dCtJza+LFroh0dZmed0gn+VNj95jKDE4hPI7
         NB/8LEfGI0R7fi6DcQxIU6++NNxBxrPTpSoqeJFSWLdZx58M9y9lRapCt5ZK4fizVnK4
         EAfb0yGWjhP8X4m//vcs+YQA3qO634cAJpPM4hcyTgQ+pDm2C5+C+ooIViQDIgvzUnaP
         bJ5g==
X-Gm-Message-State: APjAAAXIWmx6U1jiZ0GCJ0AZm/wRlNRP6tNMWVDDN1aHLIG0MH6rCAe7
        X1JFiVl7jBNOmW1aiAZxhORK4wF9zwHgaBqYQp7lujIkUEN/nlrVOme3IZkbj6k05e5D1GhLE5T
        Fft26A/xi3mAMwtZ4RbxnNl7Y
X-Received: by 2002:a1c:444:: with SMTP id 65mr1729333wme.73.1570611679950;
        Wed, 09 Oct 2019 02:01:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwQ0Spy7U6b79LWUb5d3SO9ulf2mGM4h5mzhDt6TJ71iR8Wgb7O4B9ro7AFV3M6sQU7wVNQOQ==
X-Received: by 2002:a1c:444:: with SMTP id 65mr1729308wme.73.1570611679704;
        Wed, 09 Oct 2019 02:01:19 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id a192sm1558196wma.1.2019.10.09.02.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 02:01:19 -0700 (PDT)
Subject: Re: [PATCH v3 00/16] kvm: x86: Support AMD SVM AVIC w/ in-kernel
 irqchip mode
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "graf@amazon.com" <graf@amazon.com>,
        "jschoenh@amazon.de" <jschoenh@amazon.de>,
        "karahmed@amazon.de" <karahmed@amazon.de>,
        "rimasluk@amazon.com" <rimasluk@amazon.com>,
        "Grimm, Jon" <Jon.Grimm@amd.com>
References: <1568401242-260374-1-git-send-email-suravee.suthikulpanit@amd.com>
 <ea9dd7d9-f02c-6b05-88b5-d766bb837ed3@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ea6fd945-f341-8577-2640-d0d74013a500@redhat.com>
Date:   Wed, 9 Oct 2019 11:01:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ea9dd7d9-f02c-6b05-88b5-d766bb837ed3@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/19 20:44, Suthikulpanit, Suravee wrote:
> Ping:
> 
> Hi All,
> 
> Are there other concerns or suggestions for this series?

I've now reviewed it---sorry for the delay.

Paolo
