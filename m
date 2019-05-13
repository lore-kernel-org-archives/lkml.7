Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB6FC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCC6208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOxp6Zc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfEMH2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:28:45 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46277 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbfEMH2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:28:45 -0400
Received: by mail-oi1-f193.google.com with SMTP id 203so8539783oid.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 00:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=inqo6XzBpfFXCCdJVPBLKf9Opijt817LqYON3iXApKY=;
        b=TOxp6Zc6cZKp/VDUtYtpEKVfeuc2nTD4tLl+yijhyEW06dzrim0crPf92T442t32aQ
         p+7m0gOPvlX7C/y/CfIxqlAiQFFKkUp2rBDw+y7XTzedhx0sH0UqLvCAOT+s5ACPhPrF
         B6RNUb4Q6oPqQ6wF/Pv85F/GPLy+Jq5oUk6swIALTWWPzP2FtmC0unYFi7SdQ8FGEURm
         D3p0+n8QBXx80xSSqw/fcmFBhBzBD6uEsi2bZIyW1KOkulzR8YNUK+FYPLKbRpinGEty
         JodtKqCLOfPyN/mm3IrZLc6eyH+qu0A2W5Txqmjv9YcUrrDP/pHiASsg/HhxbmdPwUR8
         eUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=inqo6XzBpfFXCCdJVPBLKf9Opijt817LqYON3iXApKY=;
        b=T4nvkVTxIujdHhBLXB5eD4JrZVj61HoG+R6y5/Ht22iEiGZx/D5H8jiCiF4WJN0J7p
         ZwWRSRMrCIl8Uztv34As8VZ9+xqljrs/dKN6oCdUyz3zPhKUDRFTuQMeuATDfHkuJpQP
         jQjceJO0LECcYETQeUr/ZiSBg1CJ9rInV/Cg2xNcO+d9q09UccM2xUj6VvoxraMQ/b/A
         QIFSjHZIRXaiAtNl+b73lnCadYJ3/JmG7tLPt4Vva23vA1Sodno612LRm282nRFM7hfs
         aHuLYb5X8GxCv9NWW7HjQC65y+FPnER7Ql665A+SHFMLE5BVlFWh40b0aJJFUYVEDGFl
         FUbg==
X-Gm-Message-State: APjAAAVK4poigIvnTLyHtOmton5/9hDnakJUGGMQI/pM2mu2Ny+ZLcb1
        2JzvF3+YSYHOnEoLGK/Yb1F65/HB
X-Google-Smtp-Source: APXvYqzKXQHo0LWZsPJk4ieZWiXeC0hvAMOoNqJK4oHn7wyFm2izPg3MdyEZcl7PL+m7efKXLFlHsw==
X-Received: by 2002:aca:54c7:: with SMTP id i190mr7239656oib.108.1557732524474;
        Mon, 13 May 2019 00:28:44 -0700 (PDT)
Received: from JosephdeMacBook-Pro.local ([205.204.117.24])
        by smtp.gmail.com with ESMTPSA id z20sm4402970otm.33.2019.05.13.00.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 00:28:43 -0700 (PDT)
Subject: Re: [PATCH] ocfs2: Fix error path kobject memory leak
To:     "Tobin C. Harding" <tobin@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20190513033458.2824-1-tobin@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <a4c16c11-15f4-cc34-9c31-69c7ce900486@gmail.com>
Date:   Mon, 13 May 2019 15:28:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513033458.2824-1-tobin@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/5/13 11:34, Tobin C. Harding wrote:
> If a call to kobject_init_and_add() fails we should call kobject_put()
> otherwise we leak memory.
> 
> Add call to kobject_put() in the error path of call to
> kobject_init_and_add().  Please note, this has the side effect that
> the release method is called if kobject_init_and_add() fails.
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
> 
> Is it ok to send patches during the merge window?
> 
> Applies on top of Linus' mainline tag: v5.1
> 
> Happy to rebase if there are conflicts.
> 
> thanks,
> Tobin.
> 
>  fs/ocfs2/filecheck.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ocfs2/filecheck.c b/fs/ocfs2/filecheck.c
> index f65f2b2f594d..1906cc962c4d 100644
> --- a/fs/ocfs2/filecheck.c
> +++ b/fs/ocfs2/filecheck.c
> @@ -193,6 +193,7 @@ int ocfs2_filecheck_create_sysfs(struct ocfs2_super *osb)
>  	ret = kobject_init_and_add(&entry->fs_kobj, &ocfs2_ktype_filecheck,
>  					NULL, "filecheck");
>  	if (ret) {
> +		kobject_put(&entry->fs_kobj);
>  		kfree(fcheck);
>  		return ret;
>  	}
> 
