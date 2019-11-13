Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CF2C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE133222D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwS8f+ot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfKMIX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 03:23:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44408 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727438AbfKMIXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573633413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=vqVZDFat0PMM6C+YZWmr17Dxnrkmoud9CsYgAO3Sp2M=;
        b=XwS8f+ot93SVV3YGkanZlSA8atMEn12wBQDallfbgwh23j9OGBzaE5rPD2T9UFmxot6Fe7
        sl6UOMSGVEl8odkxr3exqjTBK30MLI6EwKH4jPpK0Ct91YK1TPye1zx+SKZLE0VkUsorsw
        Pi541hyvle/rRL9A6wKqArTRn27nhV0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-V2xfqqTWMXivZzUCHoIIkw-1; Wed, 13 Nov 2019 03:23:30 -0500
Received: by mail-wr1-f72.google.com with SMTP id w4so1158255wro.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 00:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Mx/AGAaP+j6yF2jjolqE4bxLZFV7ALbdD3tA1UDj6I=;
        b=b7xNtmvYiieIYMcrhVCk5DMKknwaTnYoFAWBX0BObpqHWXibUN5+m/qQnaMx20j98c
         vXjpWgfTAeLeGkYPgmQLDIX7fTAS2zDw21UB5CFgAk8wXxueso5BO5O8bTJbab0ZbKx6
         lUW1iyzckOg95BWkaLsbnXnC8InHhjV6o3u+swM9Hw0cCJra0afWkPdiqUS75Rpqxv9T
         DrjIkWLSLuWooaIQc9LppoXHLBEyuVRj+0XYE0x1kSKnHXwbTPLDmAQbSkGubGC6O9ti
         UjMOzC4UDsOyalLQadH2xg8AsAYJDfArzkepidEh+p4ky3s26yklXZmWrgwU95VVNcNs
         7QSw==
X-Gm-Message-State: APjAAAWMTN73nOl7UNJD2oV9mFpKFk8eGbcy6XWyhSFtD7pzZqC7qsH7
        XRkjscMpKpWxz/tleSBQtksFSQLi3zy7Qs9v+loi3juZ4SDmREfuMrAdQAnuHromvhkbawzyWiq
        Jj85DP66q9AMTYpMYRpKnBCDC
X-Received: by 2002:a5d:4f06:: with SMTP id c6mr1555709wru.211.1573633409451;
        Wed, 13 Nov 2019 00:23:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqwiYyk8fUvAknJQ+JRzrcddJ66kvKLs3AvbR+PScIPgNAa903yr90BKUugKeMCMJGwa+X50Yg==
X-Received: by 2002:a5d:4f06:: with SMTP id c6mr1555683wru.211.1573633409147;
        Wed, 13 Nov 2019 00:23:29 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8c9d:1a6f:4730:367c? ([2001:b07:6468:f312:8c9d:1a6f:4730:367c])
        by smtp.gmail.com with ESMTPSA id 91sm1952882wrm.42.2019.11.13.00.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 00:23:28 -0800 (PST)
Subject: Re: [FYI PATCH 0/7] Mitigation for CVE-2018-12207
To:     Jan Kiszka <jan.kiszka@siemens.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        "Gupta, Pawan Kumar" <pawan.kumar.gupta@intel.com>
References: <1573593697-25061-1-git-send-email-pbonzini@redhat.com>
 <23353382-53ea-8b20-7e30-763ef6df374c@siemens.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ea5a084b-e047-6677-b8fe-d7bb6f8c0ef8@redhat.com>
Date:   Wed, 13 Nov 2019 09:23:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <23353382-53ea-8b20-7e30-763ef6df374c@siemens.com>
Content-Language: en-US
X-MC-Unique: V2xfqqTWMXivZzUCHoIIkw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/19 07:38, Jan Kiszka wrote:
> When reading MCE, error code 0150h, ie. SRAR, I was wondering if that
> couldn't simply be handled by the host. But I suppose the symptom of
> that erratum is not "just" regular recoverable MCE, rather
> sometimes/always an unrecoverable CPU state, despite the error code, righ=
t?

The erratum documentation talks explicitly about hanging the system, but
it's not clear if it's just a result of the OS mishandling the MCE, or
something worse.  So I don't know. :(  Pawan, do you?

Paolo

