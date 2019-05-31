Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74941C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511D124379
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfEaJMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 05:12:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33984 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfEaJMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:12:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id e19so7222062wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 02:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0AxDHUUpSLBZZ6pZG7HK+8YHC3CP8Xm9yOJRwOpXCuQ=;
        b=QeYMIZwXDjIPaKPR8uRKq0HBiGZVlvezHCMtqI5QW1C+x/h8NI0vGDRtWK74kcqxIp
         K6Mv0VeFlBvkmqvmUAIbko08fnYYHbuJZA1t5pPmYUkbi2SMm90eZEs8fLpMjQpHjRlD
         lqYLWjg0VuArOirauGWU3moNeWf6jXMipEhVMD47TctpomHkaoQ8PoRV/Hmmon+XGqMx
         MKJA/PTevTSxZvwpZuypP/Dn1LLd3+LTnBj6GE1xnVcSZCyfzcUnZolKY8Vhuc3KN6VO
         bQg4KSH7inhO8n58t3PGCXwpH42KPNsHla+Xd4vEoblQrl1ANV2YICggPdGov2hRNWVk
         rLcA==
X-Gm-Message-State: APjAAAXa4sAhl3VQeXWsJRhzy6UrOQy6gWRFTBQ/u+CNda1jPG56vAvy
        4um6KpKNYHKjSjgI/dS4y5YztQ==
X-Google-Smtp-Source: APXvYqyw1+UhzpIse+RJ2T972JNibsmHBYB+uO8y2y3HMDCATkvY2o+jjLDciy4QUoh9kx388sVp1Q==
X-Received: by 2002:a1c:808b:: with SMTP id b133mr4754979wmd.160.1559293942789;
        Fri, 31 May 2019 02:12:22 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id t6sm10181349wmt.34.2019.05.31.02.12.21
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 02:12:21 -0700 (PDT)
Subject: Re: [PATCH 1/2] scsi_host: add support for request batching
To:     Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, stefanha@redhat.com
References: <20190530112811.3066-1-pbonzini@redhat.com>
 <20190530112811.3066-2-pbonzini@redhat.com>
 <ad0578b0-ce73-85ed-b67d-70c5d8176a23@acm.org>
 <461fe0cd-c5bc-a612-6013-7c002b92dcdc@redhat.com>
 <740d2f33-004e-7a37-1f6e-cf29480439b1@acm.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dd00ef94-1d28-1401-2375-7603e9543e2d@redhat.com>
Date:   Fri, 31 May 2019 11:12:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <740d2f33-004e-7a37-1f6e-cf29480439b1@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/19 19:54, Bart Van Assche wrote:
> As far as I can see the only impact of defining an empty commit_rqs
> callback on the queueing behavior is that blk_mq_make_request() will
> queue requests for multiple hwqs on the plug list instead of requests
> for a single hwq. The plug list is sorted by hwq before it is submitted
> to a block driver. If that helps NVMe performance it should also help
> SCSI performance.

See the comment in blk_mq_make_request(): sorting by hwq helps NVMe
because it uses bd->last, and blk_mq_make_request() uses the presence of
the ->commit_rqs() as a sign that the driver uses bd->last.  The
heuristic basically trades latency (with plugging, the driver rings the
doorbell a bit later) for throughput (ringing the doorbell is slow, so
we want to do it less).  If the driver doesn't use bd->last and the
doorbell is always rung, plugging adds to the latency without the
throughput benefit.

All that the duplicate blk_mq_ops do is letting blk_mq_make_request()
use the same heuristic for SCSI.  This should be beneficial exactly for
the reason that you mention: if the heuristic helps non-SCSI block
driver performance, it should also help performance of SCSI drivers that
have nr_hw_queues > 1 but no commit_rqs (lpfc, qedi, qla2xxx, smartpqi,
storvsc).

Paolo

> How about always setting commit_rqs = scsi_commit_rqs
> in scsi_mq_ops?

