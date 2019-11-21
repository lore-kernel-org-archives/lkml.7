Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BACC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B972D2088F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1o3LIc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKUKiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:38:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40315 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726875AbfKUKiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574332703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gcx4NotMnfWI8ryROCazs48WfO2wapfkiUCvjD+j/TI=;
        b=e1o3LIc0pR4xQmVVnocnwRcPsw0qb9XhSrHgPuW7RzFZGZM2qCKUo8+mHALhiX2JESl719
        +I7zEEW1UEK8DqHtTZBAJR28qm774CT1snd7UwEibf8Eah6Q/3LvR9NTsDs3TOrMTNdgG/
        bBAaPNduYmYmNRCZ2vmXs14RGyD5w/0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-jE8OmELBP8q1rx54WYz0wQ-1; Thu, 21 Nov 2019 05:38:21 -0500
Received: by mail-wr1-f70.google.com with SMTP id c6so1810673wrm.18
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 02:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zCRBPyvdRSagG9bu6g7JLItNtcbbQJccmo18+XWsj1g=;
        b=KqIoSCgRZ7NCiL26IJV9P99sSqqzdQ75izKMNEy83YIRI/hDDt/88Gne/yheg2H+6v
         vuYXl5mRPmol+TFxC+z37wkx6AMHH2jgzj2thTvqUOFuXynjVYZN9YoIROrp339/8YMB
         Yd811tW4C/4eCWWufZcWKRYRWL5X/piAZdQ8pb9+SgXGNfLfzoDxXMXIRUaE88IY/gju
         u/f5rab7RVTHCBqCDR3B1T+ofRlFAps3y3rp1Di8TYYF92fMQYfCQdtF1oSNPYZ/fltv
         2BJlCezMdZI+b7H4kMgp7n8xD2H9d5mL+MMA8X5kY3EqQ8mM1Myzcxdb18Ci8qQDr7uF
         Jzkg==
X-Gm-Message-State: APjAAAUmNjoCXMGpce+eckGvh+QsOT3r/HEcF3dzhqRkL2pB2PhMHkzK
        Vl0X8CsBuYgdYx2vN0xpTEWaLphUYJEwTwlK9hnQaZEOww3xX3eR3NjnjnlDCDh3f8YIIRPe7gO
        Hrv7OrPS0AcjmECpB7ASPOMtH
X-Received: by 2002:adf:e803:: with SMTP id o3mr9693026wrm.326.1574332700003;
        Thu, 21 Nov 2019 02:38:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqyrXPnT74IzyupD1iCDtakTuMWQXc9sqwsiS9lodrPz+fHzBQXzWngw7Q9U6oB/kr7PmVmzpg==
X-Received: by 2002:adf:e803:: with SMTP id o3mr9692996wrm.326.1574332699760;
        Thu, 21 Nov 2019 02:38:19 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:71a5:6e:f854:d744? ([2001:b07:6468:f312:71a5:6e:f854:d744])
        by smtp.gmail.com with ESMTPSA id w17sm2896352wrt.45.2019.11.21.02.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 02:38:19 -0800 (PST)
Subject: Re: [PATCH v7 3/9] mmu: spp: Add SPP Table setup functions
To:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmattson@google.com,
        sean.j.christopherson@intel.com
Cc:     yu.c.zhang@linux.intel.com, alazar@bitdefender.com,
        edwin.zhai@intel.com
References: <20191119084949.15471-1-weijiang.yang@intel.com>
 <20191119084949.15471-4-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5b0da087-8ce0-2b01-5a1a-4d8c5f319d33@redhat.com>
Date:   Thu, 21 Nov 2019 11:38:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191119084949.15471-4-weijiang.yang@intel.com>
Content-Language: en-US
X-MC-Unique: jE8OmELBP8q1rx54WYz0wQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/19 09:49, Yang Weijiang wrote:
> +static int is_spp_shadow_present(u64 pte)
> +{
> +=09return pte & PT_PRESENT_MASK;
> +}
> +

This should not be needed, is_shadow_present_pte works well for SPP PTEs
as well (and in fact you're already using it here and there, so it's
confusing to have both).

Paolo

