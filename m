Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03967C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34AB2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs28ssrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389103AbfDRN6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:58:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41048 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDRN6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:58:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so1238077pgs.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 06:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=bnELcHrGjeiLVCi+rXdjq2vCxyRXpgb2ceI9sG5AGbU=;
        b=gs28ssrpYA+BhFTA76+l58aIAk7O1RNzI+qz+jSZgqxtQr5XQ6ARJdKMF9FOnLZSus
         BspvZcm/0AU2h2FK6lkkylLNTTqVvV5DOIO76sB8Ii8bRLYc/yK3zAloVA+CbYk96Vdt
         +9jwMrp09dXgOnIn4bH3X/wiH0dHSZIOfu+JEuikNvgcyjSkHxa/jV+yYZ4KMMIlzz0g
         J018PEd+W7vj1a0ydJ28FXgLK9UqGyGZ5fZ7EDpvXCnFmjdtWMSZSkZPQCyDVp/v6nCQ
         WyhA/qXxX88+OnMLz1BpMkA337Zdr1VuIzy5mGMtD+xwYLyhJWW3ftAefQpXl3OMkfct
         cQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bnELcHrGjeiLVCi+rXdjq2vCxyRXpgb2ceI9sG5AGbU=;
        b=FP+QMkj0NOXPfAA7hizaUF7qFTbq+w5w2mjKd31LXKXU/xb61IB32tgnsSSxoOO2yZ
         4coBFZSNOe3FtW+SXWyryP+8esDQs4c9yfs/SH173CD0vVsyfhh2+GeMebIqx2nrQosX
         st3NJsc2h3+hsYkLgrdD//bu3eEvF8eb2VuqphYzJpXGQ5jdka1PkNZ50Xkq12VFk3Z9
         hvlZUdHlF54MQqONqtr+OwonayG4d7ZqniDkET70Wm/+iI18Hd/UfIqgFOxdA1wC187k
         AMUXmjfGq881heomiPSa1t+7BsgfiDj19od0VSYLE7dHszK5uProAgiASbeY+JJhbdu0
         EECw==
X-Gm-Message-State: APjAAAVdqVYJEf6EPvSuCyU6NqPNhrSPbDg5Js7/tlV4OCshKxI5yAvz
        mZZl1d6AIF9x/84BoSwqRdw=
X-Google-Smtp-Source: APXvYqxV5CoDb5wjj9Kxs5WIW+JL+/fn0CAL8V1L9aJrv7HBj0WpBR5Lw5gv7QDOwUrRXwoXlief6g==
X-Received: by 2002:a63:1702:: with SMTP id x2mr5665805pgl.448.1555595919429;
        Thu, 18 Apr 2019 06:58:39 -0700 (PDT)
Received: from [192.168.0.6] ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id p189sm6371954pfg.184.2019.04.18.06.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 06:58:38 -0700 (PDT)
Subject: Re: [PATCH] nvme: determine the number of IO queues
To:     Aaron Ma <aaron.ma@canonical.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, axboe@fb.com
References: <1555510379-20199-1-git-send-email-aaron.ma@canonical.com>
 <a2f0a97e14b884dc1183db9cbdd6f4b520000ce3.camel@redhat.com>
 <096935354b16662eb481aeda1f48001ba489463c.camel@redhat.com>
 <e79703d5-3502-6519-a497-71b2b2a8768f@canonical.com>
 <99ab1942-9c38-695d-03dc-ea6eecb31217@gmail.com>
 <130f490e-e173-750d-994e-c00f7c0da080@canonical.com>
 <fbc19fb1-5e2e-ff39-5295-f38195fb8d7c@gmail.com>
 <38bc8924-e553-70d7-c91d-b6c864379b43@canonical.com>
From:   Minwoo Im <minwoo.im.dev@gmail.com>
Message-ID: <ffd4d3a7-3cfc-b69d-6045-12fdb6622f8d@gmail.com>
Date:   Thu, 18 Apr 2019 22:58:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <38bc8924-e553-70d7-c91d-b6c864379b43@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 10:38 PM, Aaron Ma wrote:
> 
> 
> On 4/18/19 9:33 PM, Minwoo Im wrote:
>> If the controller returns error for that command, how can we assure that
>> the controller would support a single I/O queue ?
> 
> Make sense, I will keep *count = 0 in V2.

IMHO, If you would like to set *count to 0, then what's gonna be V2?
I guess if some device is failed, we can make it as a quirk.

> 
> Thanks,
> Aaron
> 

