Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADAEC06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD7D218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfGDMWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:22:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40856 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfGDMWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:22:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so5923792wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 05:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XKbnehwrHnUHczUaGoUWYJWgHNQXTFxulxqCc3Hc+74=;
        b=CpVUOFjG6XtBqotvWkvx0x2z66tQBqfJsCIzIzW2ghUMPOODx64Go9pwvG9rCDakM2
         daK8YcfEDI7nmyNvBg/YpwPpbbN5fz3XHp5nJNUb8Yt5rLqNu8ay/I8TdL0/mHDeYPXE
         c3zBIKdNWBkvKBhmZgacCUOruMXx8xxS2RoheXMylKD0GccVrrUYQuJ8RLOdIyUWusLJ
         NHXFD0HussNm17JL+TET12HLleiAYJBApUx4KF0M940Dri4BdAeXGYjcDocjGeoc7AnJ
         CRim4D1jqD/gvQeSLxP+eKL3ce7KcILhgI+XcF/QZFR/sIjUkMICiiXi7+vNM7LA/lgV
         IvoA==
X-Gm-Message-State: APjAAAWbcvaTsLdLZelRGQTGOP0VXmwoWzMdcxYKMPqXUIFKfdfTTASc
        pTAS1un0l19IXW+JI5+7eraXwQ==
X-Google-Smtp-Source: APXvYqwj8nhEg9up1PX7rhJtJY7HWdQo+Hl8grcttWDYO0WeJw/d9esHC4Y09B4q6vNRUfhOC0su1A==
X-Received: by 2002:a1c:a503:: with SMTP id o3mr11839100wme.37.1562242921860;
        Thu, 04 Jul 2019 05:22:01 -0700 (PDT)
Received: from [10.201.49.68] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
        by smtp.gmail.com with ESMTPSA id a84sm6182916wmf.29.2019.07.04.05.22.00
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 05:22:01 -0700 (PDT)
Subject: Re: [PATCH 0/4] kvm: x86: introduce CONFIG_KVM_DEBUG
To:     wang.yi59@zte.com.cn
Cc:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        up2wing@gmail.com, wang.liang82@zte.com.cn
References: <201907041011168747592@zte.com.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5d3b2e72-ca07-2b85-d978-f026c608ff48@redhat.com>
Date:   Thu, 4 Jul 2019 14:22:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <201907041011168747592@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/19 04:11, wang.yi59@zte.com.cn wrote:
>> For MMU_DEBUG, the way to go is to add more tracepoints, but then
>> converting all pgprintk occurrences to tracepoints would be wrong.  You
>> can only find the "right" tracepoints when debugging MMU code.  I do
>> have a couple patches in this area, I will send them when possible.
> 
> Agreed. Hoping your patches.

I have now sent them, see "KVM: some x86 MMU cleanup and new tracepoints".

Paolo
