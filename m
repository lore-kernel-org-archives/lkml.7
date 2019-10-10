Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D90AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAB22067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="tsPN87qr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387829AbfJJJaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:30:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40786 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfJJJaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:30:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id b24so5977222wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 02:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xw2OqBpr6JQo/dUUNepFw8saT6FZ2X+9TC5O/M6JiCc=;
        b=tsPN87qrb7SnXMfk9DsBmdwnImlZtp14YDyx9V4GNwQKfsd9RH3dVINK16uvjNJ3Mv
         sKHxsnIGvftheCQvCEixkQkt/nkSmenArp8+At1aENlH/OzLZB4yPcaG7XgGkw0As9QV
         ode/fKW1AJ0jYEEo5+6dek9GIAqTxV3Y4LI2PaMdK3NALKJcQ/82jWEd16K3YMCh7v5L
         d/MPAXgbVhIFFZrj6NQhRpABv/5XI9wVyQZlSssH3m+P15AO0k2f5B1tODqSFh+o8q+5
         ijQiAb4N9fXk5X6uM828NCHG3JK3mwOnAiDqWdnsHTxaIKQMkHNb5FZlVzYxuFRwDiGe
         d+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xw2OqBpr6JQo/dUUNepFw8saT6FZ2X+9TC5O/M6JiCc=;
        b=PMv5d4cu0OEFk87EAPbCEESs8wu3xIDmvNb9xgfREoL90UPfSKaW488Do0iSVH+jfu
         VkMA7YmvjSc2b/7tLVEIYuOWbEbNzPBaT6f1HHuxnB0DCf2SeJQ7BZLN6P2W8EU8+nR4
         vJRDKM8F6sGzlSMxBpvtOlMkG67XQz7u5Vf0zdcFaQ2awkkrFXVkK4Dch+rbu1Q73gKO
         OhEzt3nxFSXzbMxJVyG82NpgT7diPbvLTBHztl9KwUcA+poqIgMMBpByCDEe5abhAIn0
         3xHhe5G5BG8xQsMtyHSccDVBUkMyCVZtR2nJxWS3mpBYID4WMWb4atbJ/ZODBsYCFMWU
         FOgA==
X-Gm-Message-State: APjAAAUxIojEyTi9hAFOV5eSZr3v7HWyb4U2b3LUUK95ACftdU8WXEoL
        SOb4w7uEc7I+Hr0wQFKtofw53g==
X-Google-Smtp-Source: APXvYqyM9PJg/Lp9na6scqs+npJ0qkkvg/faH56AjphsvyY492RXm4JJdP9hmlnb0uaKX+yaHyZTcA==
X-Received: by 2002:a7b:c849:: with SMTP id c9mr6921856wml.58.1570699816416;
        Thu, 10 Oct 2019 02:30:16 -0700 (PDT)
Received: from localhost ([85.163.43.78])
        by smtp.gmail.com with ESMTPSA id e18sm6975329wrv.63.2019.10.10.02.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 02:30:16 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:30:15 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] genetlink: do not parse attributes for families
 with zero maxattr
Message-ID: <20191010093015.GF2223@nanopsycho>
References: <20191009164432.AD5D1E3785@unicorn.suse.cz>
 <20191010083958.GD2223@nanopsycho>
 <20191010091347.GA22163@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010091347.GA22163@unicorn.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Oct 10, 2019 at 11:13:47AM CEST, mkubecek@suse.cz wrote:
>On Thu, Oct 10, 2019 at 10:39:58AM +0200, Jiri Pirko wrote:
>> Wed, Oct 09, 2019 at 06:44:32PM CEST, mkubecek@suse.cz wrote:
>> >Commit c10e6cf85e7d ("net: genetlink: push attrbuf allocation and parsing
>> >to a separate function") moved attribute buffer allocation and attribute
>> >parsing from genl_family_rcv_msg_doit() into a separate function
>> >genl_family_rcv_msg_attrs_parse() which, unlike the previous code, calls
>> >__nlmsg_parse() even if family->maxattr is 0 (i.e. the family does its own
>> >parsing). The parser error is ignored and does not propagate out of
>> >genl_family_rcv_msg_attrs_parse() but an error message ("Unknown attribute
>> >type") is set in extack and if further processing generates no error or
>> >warning, it stays there and is interpreted as a warning by userspace.
>> >
>> >Dumpit requests are not affected as genl_family_rcv_msg_dumpit() bypasses
>> >the call of genl_family_rcv_msg_doit() if family->maxattr is zero. Do the
>> >same also in genl_family_rcv_msg_doit().
>> 
>> This is the original code before the changes:
>> 
>>         if (ops->doit == NULL)
>>                 return -EOPNOTSUPP;
>> 
>>         if (family->maxattr && family->parallel_ops) {
>>                 attrbuf = kmalloc_array(family->maxattr + 1,
>>                                         sizeof(struct nlattr *),
>>                                         GFP_KERNEL);
>>                 if (attrbuf == NULL)
>>                         return -ENOMEM;
>>         } else
>>                 attrbuf = family->attrbuf;
>> 
>>         if (attrbuf) {
>>                 enum netlink_validation validate = NL_VALIDATE_STRICT;
>> 
>>                 if (ops->validate & GENL_DONT_VALIDATE_STRICT)
>>                         validate = NL_VALIDATE_LIBERAL;
>> 
>>                 err = __nlmsg_parse(nlh, hdrlen, attrbuf, family->maxattr,
>>                                     family->policy, validate, extack);
>>                 if (err < 0)
>>                         goto out;
>>         }
>> 
>> Looks like the __nlmsg_parse() is called no matter if maxattr if 0 or
>> not. It is only considered for allocation of attrbuf. This is in-sync
>> with the current code.
>
>If family->maxattr is 0, genl_register_family() sets family->attrbuf to
>NULL so that attrbuf is also NULL and the whole "if (attrbuf) { ... }"
>block is not executed.

Ah, I missed that. Thanks!

>
>Michal
