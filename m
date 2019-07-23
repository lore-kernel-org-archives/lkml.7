Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866DCC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B13218A0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="djQaLMYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbfGWSCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:02:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32837 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfGWSCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:02:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id f20so10566031pgj.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 11:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KlX8mnc2TLKGzdYuaVA7PerYYgEg13kGbXM6bN4nXSw=;
        b=djQaLMYDSvS5ovODS2W3nM9t/QQHs8PEXoTjQ3wOqww5bxOB6jjf2EvKlkBc/5fE3q
         BJjyIgQgUmj4qSXtatSBNLNHCmzSkvEYiIb+UotUf0YhghHTj01C7r+20ybsUeFWYY2E
         apbhNSfYemvuIuXIs5Ma8RWBRtklH0JsONLwwptCeU/CqOa5qpN5hpRh4fLR464kGsCR
         uvOGT6jxC6avBpOIJg7ktKk6tThvF/XQS9JyVGenM6lYOJFeCTzlfOmlZSfIub/ef3H/
         +xqDfJbZj53J7/gr6UucKldZYnWMREF+dKF3NJiMCHT+MCVaTozd76SVcQFGcamAbYeY
         c9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KlX8mnc2TLKGzdYuaVA7PerYYgEg13kGbXM6bN4nXSw=;
        b=pSstiSjBI5rdJvCw8UGLhS++6jYujuWSQxsMGSe++MOxL9hCVVHy25IMx2yYtY1+wQ
         PyJ1ROKgAHrpvetgQQck/gxKxdLH34ywyU3eEdkpgLzc4XaNs++Igan6Hyh+UGpSWyIL
         J/u3JTMWoCZ2zzc7P3Z7si7Yn0+B5hHi/6yaRGLT2v2LL930IYVu8lnYXsLzTaapZWPN
         lT+Mo6DfaIAgzUJjrWpGZAFBashsJDjivQEXX/c8Iso5YbrAnjbaWzKgyY4esCoIKyrV
         CnUOZiLEdt6drpZnk+adjuI8XIswkR+bfmUmfedMv95EgBW5YJOpRDPG7D+rahm2pfH4
         TJZA==
X-Gm-Message-State: APjAAAXBJsUE49rldEkE0Q9pUvAIpL27/Yu+k2nFIWNo0DBz5jyjMxRU
        9YN2TfYj/5hIIzpVEw2kyYI=
X-Google-Smtp-Source: APXvYqzIgBXnU6wzzkXzpwwGZURWO1rt0vC60ojlkFvbhS21CULv5JVdD3dQkiUF4DvD9dfeKE+qJQ==
X-Received: by 2002:a62:3c3:: with SMTP id 186mr6989648pfd.21.1563904933318;
        Tue, 23 Jul 2019 11:02:13 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id z6sm15486251pgk.18.2019.07.23.11.02.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 11:02:13 -0700 (PDT)
Date:   Tue, 23 Jul 2019 11:02:06 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        David Ahern <dsahern@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] netlink: add validation of NLA_F_NESTED
 flag
Message-ID: <20190723110206.4cb1f6b1@hermes.lan>
In-Reply-To: <6b6ead21c5d8436470b82ab40355f6bd7dbbf14b.1556806084.git.mkubecek@suse.cz>
References: <cover.1556806084.git.mkubecek@suse.cz>
        <6b6ead21c5d8436470b82ab40355f6bd7dbbf14b.1556806084.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 May 2019 16:15:10 +0200 (CEST)
Michal Kubecek <mkubecek@suse.cz> wrote:

> Add new validation flag NL_VALIDATE_NESTED which adds three consistency
> checks of NLA_F_NESTED_FLAG:
> 
>   - the flag is set on attributes with NLA_NESTED{,_ARRAY} policy
>   - the flag is not set on attributes with other policies except NLA_UNSPEC
>   - the flag is set on attribute passed to nla_parse_nested()
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> 
> v2: change error messages to mention NLA_F_NESTED explicitly

There are some cases where netlink related to IPv4 does not send nested
flag. You risk breaking older iproute2 and other tools being used on newer
kernel. I.e this patch may break binary compatibility. Have you tried running
with this on a very old distro (like Redhat Linux 9)?

