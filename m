Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275F9C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB752208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6awC/yq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfFMVFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 17:05:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36941 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbfFMVFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 17:05:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so32844pfa.4;
        Thu, 13 Jun 2019 14:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nGIzlfyMtWXfYkMWkeMnt3GQvr8tI9iFdtflB9NEcR0=;
        b=o6awC/yqgP89v7ZNzJm+Vx0n0TInFJFUyczt/ABMUyhorQQGQDKQvbAfmBt2ATTh0Z
         0ovpyLfusP6v4zOcfT+7TnPp3cgeBSCryK0nGaorfLAQ8+ynXkvwYFD5B6ljHYyOrwR8
         H2qTa3TrFVLw6PRdQYwfY8Ag08UlwPS/JNvdoxxLdh1ObEOImmVHFQ1hWMRksGToCnBh
         zkn59dDEATw5M9p8RFqM1o4WldRjDnie09yFqcfYvFR7C3Dy06qqAIT6/3f5HbJgH9lY
         BV2JUyjZdCBNTwwhjS6E4V2anyayn1sJAM995XwS40QlwNC02tkCl6cfNDB7VyEZQq1J
         hcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nGIzlfyMtWXfYkMWkeMnt3GQvr8tI9iFdtflB9NEcR0=;
        b=tlZf4S0cg/4+ApvZj4+y4SERg2trr1M1Cjv99I62+Vvofusf/Tr6uYfHD9nwtCardo
         bhmZepz6wSni0W/zZdBhvI8nrP9RyQlZhKprQOnV0b97TS4N2LjSUDsQozjk4rfmzSbk
         EF8W/6xwZWtZIOXieacDq9UeSRvCK13NCWD6pZNG28gkTvMUZDx0v8JDiFXo+z/F25UC
         N05zqUKUwxJrYX7onkkO9Cv8M9DulyWpctMX7riBkE7q5Gm7yc6ZjBrvAyWsb1jVInAp
         jWxVV9wcGcuUUHKjg89D78Ffd64IEN3zX48sIaXIa+ipCT7LXWcEilgyItfVk4Ep3AUc
         buag==
X-Gm-Message-State: APjAAAVLo0X5b7x1KiPzS0ULVuPZekfwMHUG5w8oTUFIgZ0jNg+a3kL0
        ZlbdDledlGDVcwj+e8scpB0=
X-Google-Smtp-Source: APXvYqwAEyjLJQfMr+GN6f4kQuA5+N8IXcoBqBcGgZCHosfwOJRCA+Nsr6KriKTTOtkhDtsF/Y4bMA==
X-Received: by 2002:a62:3543:: with SMTP id c64mr12639125pfa.242.1560459936281;
        Thu, 13 Jun 2019 14:05:36 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id 128sm599697pff.16.2019.06.13.14.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 14:05:35 -0700 (PDT)
Date:   Fri, 14 Jun 2019 06:05:33 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Minwoo Im <minwoo.im@samsung.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "MPT-FusionLinux.pdl@broadcom.com" <MPT-FusionLinux.pdl@broadcom.com>,
        "sathya.prakash@broadcom.com" <sathya.prakash@broadcom.com>,
        "chaitra.basappa@broadcom.com" <chaitra.basappa@broadcom.com>,
        "suganath-prabu.subramani@broadcom.com" 
        <suganath-prabu.subramani@broadcom.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Sarah Cho <sohyeon.jo@samsung.com>,
        Sungjun Park <sj1228.park@samsung.com>,
        Gyeongmin Nam <gm.nam@samsung.com>,
        Sanggwan Lee <sanggwan.lee@samsung.com>
Subject: Re: [RFC PATCH] mpt3sas: support target smid for [abort|query] task
Message-ID: <20190613210533.GA25375@minwooim-desktop>
References: <CGME20190613075402epcms2p7dbd2e2f7c80bd2aef2c5dd3736393d36@epcms2p7>
 <20190613075402epcms2p7dbd2e2f7c80bd2aef2c5dd3736393d36@epcms2p7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190613075402epcms2p7dbd2e2f7c80bd2aef2c5dd3736393d36@epcms2p7>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-13 16:54:02, Minwoo Im wrote:
> We can request task management IOCTL command(MPI2_FUNCTION_SCSI_TASK_MGMT)
> to /dev/mpt3ctl.  If the given task_type is either abort task or query
> task, it may need a field named "Initiator Port Transfer Tag to Manage"
> in the IU.
> 
> Current code does not support to check target IPTT tag from the
> tm_request.  This patch introduces to check TaskMID given from the
> userspace as a target tag.  We have a rule of relationship between
> (struct request *req->tag) and smid in mpt3sas_base.c:
> 
> 3318 u16
> 3319 mpt3sas_base_get_smid_scsiio(struct MPT3SAS_ADAPTER *ioc, u8 cb_idx,
> 3320         struct scsi_cmnd *scmd)
> 3321 {
> 3322         struct scsiio_tracker *request = scsi_cmd_priv(scmd);
> 3323         unsigned int tag = scmd->request->tag;
> 3324         u16 smid;
> 3325
> 3326         smid = tag + 1;
> 
> So if we want to abort a request tagged #X, then we can pass (X + 1) to
> this IOCTL handler.
> 
> Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
> ---

Sorry for the duplicated patches on the same mailing list.  Please ignore
the first two of it.

Thanks,
