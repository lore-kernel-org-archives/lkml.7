Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34E2C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769492070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564426301;
	bh=Gv5AzgJVYR0OR8ORqDsTIgG2lMNj1bZUmB0KGfpUC0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bP6Fbxvi6/k43jE7BoPafU79blIfUufTiAnOlO9wrcQawhi4T8CA5vflYwvdCQP9O
	 mVZ0kzlsKFUvZr5DNpJatBklxaPRUzPBEImllEF29XDGxc5P9g0pMv0BTpKayv2Aod
	 ro8KaESacRx1aNXSCZadJFNdRwWQsF3qEHTzyzRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbfG2Svj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 14:51:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37907 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbfG2Svi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 14:51:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id f5so19880415pgu.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 11:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mIzsxTD2036Q7QvIHHotBeBumqv5A66UAXgo+x9j748=;
        b=cg0o23QRoMZ7W5DbVCtainjm3/p+NSRaI05Vu0Bz5krkrO5GVWvFPs0adN5GfmlWSX
         wLG0DouSgJyAsN0hE7Zp5lIU6xY3J1raD23/x3600j0tFJ7WmDCXgriz9Z4Rn0qEyCld
         ggYydjo8qEBn4y/45mxZdJThF2cdjhyUKFkOI6bQ2VCEo3XXVp5NaNm9j+tL7AwA73mm
         5s5gKMPNa8m5UDg7QrZkaamYwVV/5fhH5YuBUEuXDDov38ab/ForJfHBdpQR+mlnHXlq
         mfmAtZ0WL97oVID2PcUYjEGyj9bZxL1U/OJnJ9DBfexlEdwNoPfvYYk34GF6/SXuzOvG
         JaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mIzsxTD2036Q7QvIHHotBeBumqv5A66UAXgo+x9j748=;
        b=Z2PaHl5haX9oXwwHndQZWgUckt1CrbktnOSGtBsRjg7BK6GQVXMoU+Mka3wMcbEwf2
         8n/kh/6XHNUsw7RYruz5LdWCtP87QPih/CAW3NJ8lLJ0IvbSmMPXnmnwR7CEsB3+l+dl
         MXo1jNjL7wIU8u2DtBMA3MKTMbylsM5bEAyNSq5fp9ofO3Ib9WnAiZVkYcAUJPZueYfm
         Up2XZdqgRpNgWzxYIiGY3x8HdM3EDw24sTnx8ZvKZnUoDhD8if1EYbZyG+3O2zvnppyA
         9mX7ysKfSYt7KvrjGvdKg0dXNMU8fFgbNgj1G+VjmoMpKDvwQvpnBoxfWOF8/PvDEEmf
         LZhg==
X-Gm-Message-State: APjAAAXA8qaUbF9Nsg9TXtfA6rTJIw3a4pJwPLDDVmdPo8YHaJqy474s
        l0oafvj9hbOkBh5q6jgl0is6IDB2
X-Google-Smtp-Source: APXvYqyB72GINqzqkmpUpMmCQJpl67wduDAAaEMOfR8V6m6sgGtR8uNh0RiYqWJ8vLsnYAGxQq+v9A==
X-Received: by 2002:a62:3543:: with SMTP id c64mr37171137pfa.242.1564426297958;
        Mon, 29 Jul 2019 11:51:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:309b])
        by smtp.gmail.com with ESMTPSA id f64sm65823853pfa.115.2019.07.29.11.51.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 11:51:36 -0700 (PDT)
Date:   Mon, 29 Jul 2019 11:51:33 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: kernfs: Fix possible null-pointer dereferences in
 kernfs_path_from_node_locked()
Message-ID: <20190729185133.GD569612@devbig004.ftw2.facebook.com>
References: <20190724022242.27505-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724022242.27505-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:22:42AM +0800, Jia-Ju Bai wrote:
> In kernfs_path_from_node_locked(), there is an if statement on line 147
> to check whether buf is NULL:
>     if (buf)
> 
> When buf is NULL, it is used on line 151:
>     len += strlcpy(buf + len, parent_str, ...)
> and line 158:
>     len += strlcpy(buf + len, "/", ...)
> and line 160:
>     len += strlcpy(buf + len, kn->name, ...)
> 
> Thus, possible null-pointer dereferences may occur.
> 
> To fix these possible bugs, buf is checked before being used.
> If it is NULL, -EINVAL is returned.
> 
> These bugs are found by a static analysis tool STCheck written by us.

Can we just get rid of the NULL testing?

Thanks.

-- 
tejun
