Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C664DC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9843F21479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="0hh+fBsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfGBOzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:55:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39749 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBOzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:55:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id j2so8365702pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8cXSaF+p7DJJ3fZFu8jVrLy+krn1VYp+KO+1g81m2HI=;
        b=0hh+fBsSTKqONYkY5IWchEOsM9q4yZxRMIwfIJXepa2yZShqwzk4b9L2oD1S+tQWBa
         H/eA4zSEPm9dikIiJ4zysqbuldx53abH6jiU6OXP/0Uz13Gqh97HR/1Es6aEpqoK6xA5
         7mGYFiidHQU8PmzXdjRlghY8YEVMcG7Zg/zr02qORI8P8b2YhF5fEBDY0BHZEPKfhzoG
         TCH0LyHiEfgNeTF8zy1rjnDIBVX+30WGIEmZj0g3YxzdA/9uhPN79OGDL6rn2uPEoCK7
         4ayfRzbB7RsrAFN9E4S477frVwrU1utp5vd/zV860EMBOlNMFQVT0UbT9Rkvpo5IjZg8
         s6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8cXSaF+p7DJJ3fZFu8jVrLy+krn1VYp+KO+1g81m2HI=;
        b=l1cf8JbsM3x66mLFXvU7hxXaK7GFYwyvJ9VvTqWg5yKgVIfKoxXYEnH7QE6bZnxytZ
         I1XNoBwScFM/YtzuvxlHsNTS11c5WOPo20NtiB9zJEhZCqB9xSkGTqn3sPnzpLkw8n+D
         q2/mbI0+NM0mUHGbb2+HZcL18Ps1lxURfVChBoSv4K6yogjfO4bmmkHpoODWuB0TW1jC
         XwWwnYNEUQ16vcVoQWWGc6wX20/tM71ucsT41+T5riGI7XzxdMHsxoGDkQI/Jc4s7M56
         MSFzZ91T2A6XlS96W1QErcW6lTF6NGEq2CGBX4JLFWh/LmP1m6l0pPU/RAZDMX2Lh25i
         ifbA==
X-Gm-Message-State: APjAAAW7+5T800Z5IyBmE0v/z0cxdNLRsNqo0zYH6Jn/jMIOnNcLGSca
        ycMK8WfYkZncoP2AmqX6fp16yhY9Lgw=
X-Google-Smtp-Source: APXvYqxwZkI8Twf6+IMiX/h0XEIV+H0p9gEKUIHpRjcl7Oz15aF76lk0oNq1OZ7k0nec8hOfwYba5w==
X-Received: by 2002:a17:90a:d997:: with SMTP id d23mr5819114pjv.84.1562079309742;
        Tue, 02 Jul 2019 07:55:09 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id 10sm19371297pfb.30.2019.07.02.07.55.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 07:55:09 -0700 (PDT)
Date:   Tue, 2 Jul 2019 07:55:00 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 01/15] rtnetlink: provide permanent hardware
 address in RTM_NEWLINK
Message-ID: <20190702075500.1b9845e1@hermes.lan>
In-Reply-To: <b6e0aefbcb58297b3ec0a12ee4be8e5194eee61a.1562067622.git.mkubecek@suse.cz>
References: <cover.1562067622.git.mkubecek@suse.cz>
        <b6e0aefbcb58297b3ec0a12ee4be8e5194eee61a.1562067622.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Jul 2019 13:49:44 +0200 (CEST)
Michal Kubecek <mkubecek@suse.cz> wrote:

> Permanent hardware address of a network device was traditionally provided
> via ethtool ioctl interface but as Jiri Pirko pointed out in a review of
> ethtool netlink interface, rtnetlink is much more suitable for it so let's
> add it to the RTM_NEWLINK message.
> 
> Add IFLA_PERM_ADDRESS attribute to RTM_NEWLINK messages unless the
> permanent address is all zeros (i.e. device driver did not fill it). As
> permanent address is not modifiable, reject userspace requests containing
> IFLA_PERM_ADDRESS attribute.
> 
> Note: we already provide permanent hardware address for bond slaves;
> unfortunately we cannot drop that attribute for backward compatibility
> reasons.
> 
> v5 -> v6: only add the attribute if permanent address is not zero
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Do you want to make an iproute patch to display this?

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
