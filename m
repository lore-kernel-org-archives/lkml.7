Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF07C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF07621852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfGDNTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 09:19:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37959 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfGDNTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 09:19:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so1119641wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 06:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cb7K86i4xSjnh5aO2/GCpQl2NYXJ9GZdRLXhfhoypnU=;
        b=Dz9L2VuCqmjqk1YJZ+RTEMqaGcbPbHk0ybkVLDgwRWVeqnYrCyEg2ssLq6pPpOuxsc
         L8D8W8AX3wtRiyzpSukqrYrxzXUgzdx6dkuW/4wd+GDX9OgoKZAMhbtgTngX+qP1t7fb
         8xCmKFSA13HVt2A8ZUEQ4yn7NOfEttkZFSGNsHrxjQQUlM0ttjYYOy0NrMIc2U908rSO
         ynF6oVgKY4uVrfEFIKh74iINb/LwYsWBlWP9MhV56Y29zTPm1is+2aaKq2d1k5Z2rpNh
         HruWnvqnPSb8P5K8LsUhlHR2TGwn9APchYa5DzaW7ingsEjYoo3q1nSUg0fNl66L/dB8
         tKgg==
X-Gm-Message-State: APjAAAXTCAv+0wA+tQC6h0i3ktc6fhy2BBCwOqI646CBUR4RzgexPiKQ
        13xI9YNo9/jJ8C0b5/ijO/iSRQ==
X-Google-Smtp-Source: APXvYqwnnWTvg4XiNApaaKbLCKKQnP2Dttz0Wp5dirkAI4GqqKYrAYZTEHuEKyVf9YNKab5gwyCQUA==
X-Received: by 2002:a5d:6190:: with SMTP id j16mr35368415wru.49.1562246350384;
        Thu, 04 Jul 2019 06:19:10 -0700 (PDT)
Received: from [10.201.49.68] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
        by smtp.gmail.com with ESMTPSA id l13sm121009wrt.16.2019.07.04.06.19.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 06:19:09 -0700 (PDT)
Subject: Re: [PATCH 1/2] scsi_host: add support for request batching
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, stefanha@redhat.com
References: <20190530112811.3066-1-pbonzini@redhat.com>
 <20190530112811.3066-2-pbonzini@redhat.com>
 <760164a0-589d-d9fa-fb63-79b5e0899c00@suse.de>
 <aaa344bf-af29-0485-4e83-5442331a2c9c@redhat.com>
Message-ID: <afea12a1-47b3-0ebe-a3c2-6adc615bbddf@redhat.com>
Date:   Thu, 4 Jul 2019 15:19:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <aaa344bf-af29-0485-4e83-5442331a2c9c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/19 12:31, Paolo Bonzini wrote:
>> I'm a bit unsure if 'bd->last' is always set; it's quite obvious that
>> it's present if set, but what about requests with 'bd->last == false' ?
>> Is there a guarantee that they will _always_ be followed with a request
>> with bd->last == true?
>> And if so, is there a guarantee that this request is part of the same batch?
> It's complicated.  A request with bd->last == false _will_ always be
> followed by a request with bd->last == true in the same batch.  However,
> due to e.g. errors it may be possible that the last request is not sent.
>  In that case, the block layer sends commit_rqs, as documented in the
> comment above, to flush the requests that have been sent already.
> 
> So, a driver that obeys bd->last (or SCMD_LAST) but does not implement
> commit_rqs is bound to have bugs, which is why this patch was not split
> further.
> 
> Makes sense?

Hannes, can you provide your Reviewed-by?

Thanks,

Paolo
