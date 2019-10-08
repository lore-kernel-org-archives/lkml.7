Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FA1C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D75206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfJHQdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 12:33:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfJHQdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:33:18 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D066D121D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2019 16:33:17 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id y10so19604188qti.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 09:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0emuj7ckCeOi2ShbRboaosDgyEFD8QY/GtdLIcv15Yo=;
        b=qxwDUnlr/FrV2/nMRc50mO3Js9t7Ow81WtrjO9oFlZLh5LARiakcToDabWYj5EltU5
         1bEI9pxBfBjd+Mf32NOyNGFMCGjK+/DagdjOrtmMNOn/vUf+FsQUad97zq4TW3feh6ft
         SsZoAblsweZuSmsMnQcqmL24tQrKzJu59qr0bimQvdiHjN/+7U+SFd2fDi5f6X/GzoQq
         PGyqciRgKLvym6fDFG4re3JVmoY9eZAom2Ul57hVnf2BvoYRCg+EWWHHJ8GQ7KTEriGM
         bjTWZHDf6KL7rRByyk8DJto/1RuH8swNgJV8dvhiwnp66AjL2GVbW+0vhGRWqVaUSBdh
         12Zg==
X-Gm-Message-State: APjAAAXTn2dUk60D2fYlNHNnrfZSvsXer7OWcpX/E5AmhFKTT2s+X0Z2
        lRCIZ3v/L9d7kzHGnddjP1o/sCC97UzY/LGT1zBXQSDN2BNzH26ojZ5EJeeaWROV5xr/mVwqugq
        qWFyZBL9HtJaSlgPxu/JIdjj+
X-Received: by 2002:ac8:2966:: with SMTP id z35mr37722115qtz.348.1570552397040;
        Tue, 08 Oct 2019 09:33:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqygwcCLbNfX37PFFgvJBMHiAJ+4DIe1+sjK4nzF87cpY0peuIfCoM/lAQubKQGhuVDDY9RmBw==
X-Received: by 2002:ac8:2966:: with SMTP id z35mr37722061qtz.348.1570552396613;
        Tue, 08 Oct 2019 09:33:16 -0700 (PDT)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id n192sm8999408qke.9.2019.10.08.09.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 09:33:15 -0700 (PDT)
Subject: Re: mount on tmpfs failing to parse context option
To:     Al Viro <viro@zeniv.linux.org.uk>, Hugh Dickins <hughd@google.com>
Cc:     David Howells <dhowells@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
References: <d5b67332-57b7-c19a-0462-f84d07ef1a16@redhat.com>
 <d7f83334-d731-b892-ee49-1065d64a4887@redhat.com>
 <alpine.LSU.2.11.1910071655060.4431@eggly.anvils>
 <20191008012622.GP26530@ZenIV.linux.org.uk>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <9349bbbe-31fe-2b0a-001d-2e22ee20c12f@redhat.com>
Date:   Tue, 8 Oct 2019 12:33:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191008012622.GP26530@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/19 9:26 PM, Al Viro wrote:
> On Mon, Oct 07, 2019 at 05:50:31PM -0700, Hugh Dickins wrote:
> 
> [sorry for being MIA - had been sick through the last week, just digging
> myself from under piles of mail; my apologies]
> 
>> (tmpfs, very tiresomely, supports a NUMA "mpol" mount option which can
>> have commas in it e.g "mpol=bind:0,2": which makes all its comma parsing
>> awkward.  I assume that where the new mount API commits bend over to
>> accommodate that peculiarity, they end up mishandling the comma in
>> the context string above.)
> 
> 	Dumber than that, I'm afraid.  mpol is the reason for having
> ->parse_monolithic() in the first place, all right, but the problem is
> simply the lack of security_sb_eat_lsm_opts() call in it.
> 
> 	Could you check if the following fixes that one?
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0f7fd4a85db6..8dcc8d04cbaf 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3482,6 +3482,12 @@ static int shmem_parse_options(struct fs_context *fc, void *data)
>   {
>   	char *options = data;
>   
> +	if (options) {
> +		int err = security_sb_eat_lsm_opts(options, &fc->security);
> +		if (err)
> +			return err;
> +	}
> +
>   	while (options != NULL) {
>   		char *this_char = options;
>   		for (;;) {
> 

Yes the reporter says that works.

Thanks,
Laura
