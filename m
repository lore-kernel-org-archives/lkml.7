Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2523CC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 11:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5EC206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 11:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="oWfC2NQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732786AbfJJL05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 07:26:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37596 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfJJL05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 07:26:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id f22so6379004wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 04:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OYpDDuL7BYuuwlHxQgZR0G54AZSewtaA2OCEr7V/XNs=;
        b=oWfC2NQLiLTJO+/rnLDDJMp6qooPWYRbjPraT9E4RsPT47AsjFw5x3BODvrlkI0vnZ
         A3DcOU77YQQWKUBFLgiA8TpaFXjS3Fm8gTdi7zEiwTvxg87lKBYjc/hC7A60NJiqFQ/Q
         I6NX5JbRH2wGosPdJ6N3cGWLLWncK27mnBWwjVkCpJQSbZ0iBoittiahoFEuP189FTMp
         4GSYkK6xcOaYoD0jnlI9VldVsCsy1SOf6ALk5iX2OLoLgj3D/fI1qwauFkOn27WV92jl
         tyZ+GqqBBWWTxwIcxgXfA5JM025CskvH5lO7rNrytqLRR59IBm8EeC2WkqMxtHZdwHfJ
         9ELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OYpDDuL7BYuuwlHxQgZR0G54AZSewtaA2OCEr7V/XNs=;
        b=SVf/G6in8x/kVvj+XmFpJTKZmnhlbRARO69jbNW1XUPVAiqTuKHzklddwgeqg7uulJ
         +fq+ICHBFMYbAxI+u05VtcHUVfKflw32N+iWBlDNUgnZqvUUHGYmcAb9mk0gJQA6RHT6
         GtWRJSxQygwqWYV3mkj1qrVoLPwOa43Yo6vvfgV/mAQ7Ad9KrK93dN7NRBJ0QnO43hzF
         1NGjMS/OBzhaRLfniRFsRQxUpE/nPPEFL+0/ByQoSC3cePnSJYZb2SD/Xb3OPxsIiD5J
         5MT+SwOaefvw0OymQfkzFr5qojr+yT52onlrFEeHqDzbr/Y70WedKC3tV4GqsL3AL0Z5
         06tg==
X-Gm-Message-State: APjAAAWwHiDWnAQhSfTmVm252ZSIpyb5wYkYLde691dlk7l6cMvRerlg
        2ClbIUlPonAro/R7fSoyryXkrw==
X-Google-Smtp-Source: APXvYqw0MVhZgnXQnTrF4od9h9VNlpyRH+v8Sy9tE0gTrLQ70fnldWEAwPs7Z8s8EXq66Byni0wJhw==
X-Received: by 2002:a7b:ce12:: with SMTP id m18mr510289wmc.108.1570706815333;
        Thu, 10 Oct 2019 04:26:55 -0700 (PDT)
Received: from localhost ([85.163.43.78])
        by smtp.gmail.com with ESMTPSA id v7sm5343827wrr.4.2019.10.10.04.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 04:26:54 -0700 (PDT)
Date:   Thu, 10 Oct 2019 13:26:54 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] genetlink: do not parse attributes for
 families with zero maxattr
Message-ID: <20191010112654.GH2223@nanopsycho>
References: <20191010103402.36408E378C@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010103402.36408E378C@unicorn.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Oct 10, 2019 at 12:34:02PM CEST, mkubecek@suse.cz wrote:
>Commit c10e6cf85e7d ("net: genetlink: push attrbuf allocation and parsing
>to a separate function") moved attribute buffer allocation and attribute
>parsing from genl_family_rcv_msg_doit() into a separate function
>genl_family_rcv_msg_attrs_parse() which, unlike the previous code, calls
>__nlmsg_parse() even if family->maxattr is 0 (i.e. the family does its own
>parsing). The parser error is ignored and does not propagate out of
>genl_family_rcv_msg_attrs_parse() but an error message ("Unknown attribute
>type") is set in extack and if further processing generates no error or
>warning, it stays there and is interpreted as a warning by userspace.
>
>Dumpit requests are not affected as genl_family_rcv_msg_dumpit() bypasses
>the call of genl_family_rcv_msg_doit() if family->maxattr is zero. Do the
>same also in genl_family_rcv_msg_doit().
>
>Fixes: c10e6cf85e7d ("net: genetlink: push attrbuf allocation and parsing to a separate function")
>Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Acked-by: Jiri Pirko <jiri@mellanox.com>

Thanks!
