Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42845C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1979220882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732114AbfDBN4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:56:10 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:46731 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731186AbfDBN4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:56:09 -0400
Received: by mail-pg1-f179.google.com with SMTP id q1so6603752pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 06:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nMqjSd+oT7uXJW6qIDnyh7P8CfOvT/Le0ziyyXosUHA=;
        b=NC7ZVzmrNW92EKKx/5CZkhvGjaKUVb2rurQlv4xqPUu3MlGNWiGyCo13vrnD/Tf+Ct
         WQSTKXOTPy1/gyqrPDmca9DqLCOKHxBoqyKnyyDy5AdJFPI6x0CLi2tLjttqe4v6R3Vy
         Vq4Wd9NRB+3DWKCdnuu6uO/GFk2cHIvs4HE+xeFQ1BxbMC61rV3St+cYJdz4t/YKWTRK
         7esTD2Ouof3ZIc7cfCVeKLgynt57w8E01KL8jJR/FxpVrRdEt5tB1CpUvlMTMj4ykrMF
         rdAVoxd0Ilmm/84yO5F7edtTG0PRx2A3VclqHWcGdHnSl/ZtlsdzrBQPk3RxXxpDqK08
         U+OQ==
X-Gm-Message-State: APjAAAWnYgZ9/0W47GhcdrdK/OQ8cAhL0sIUbgUdsQxt4Y3jz3KWKfYG
        inrVVgH2fJM6WGor5bGIhuI2Lli5
X-Google-Smtp-Source: APXvYqyAgYIB0+r8rFwmH5dARZc8sLkna7KxCwputWvxKHHMGe7dxBJZNsnbnUu2Zf82NHZ8eZNbyw==
X-Received: by 2002:a63:d5f:: with SMTP id 31mr20322582pgn.208.1554213368947;
        Tue, 02 Apr 2019 06:56:08 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id v20sm14978535pfe.118.2019.04.02.06.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 06:56:08 -0700 (PDT)
Subject: Re: [block] 67dc83c6fb:
 WARNING:at_block/blk-core.c:#blk_cleanup_queue
Cc:     Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>
References: <20190402104526.auvvpgcqxnsris5u@inn2.lkp.intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <aaa3d38d-7fc7-4085-e2f4-6deba301ad50@acm.org>
Date:   Tue, 2 Apr 2019 06:56:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190402104526.auvvpgcqxnsris5u@inn2.lkp.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/19 3:45 AM, kernel test robot wrote:
> [   12.540233] WARNING: CPU: 0 PID: 43 at block/blk-core.c:353 blk_cleanup_queue+0xcc/0xe0

Please ignore this kernel test robot report. It applies to a patch that 
I sent to the build robot but that was never posted on any mailing list.

Thanks,

Bart.

