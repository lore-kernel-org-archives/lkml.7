Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7300C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D8F21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Scqdsfup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfEWBRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 21:17:42 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:43723 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWBRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 21:17:42 -0400
Received: by mail-pl1-f174.google.com with SMTP id gn7so1896957plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 18:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=clAxQ37OE8bsUk7gVdrKB+HDUP0KUPp+G1oPTKfKdDc=;
        b=ScqdsfupCb7NmB9U/D/GcTBTic5TSqxyWBVFvc0F6ofWaz0O4bev7rxjtyocYvoMGV
         HPxWcxz1kgXs+SPT9AfVA5YVchY+iE5X1PwL47/N8Ms7pDRfsxABaIlizM/QLmVGWCjG
         sUZyd5u8sKMuPsG6V/cTHwZRPqLCnNeGejzcyn1sBkDEe77CPyzIu1tGLr+H+i/uMEDH
         8vD4GInOhLglcva4hgphHgiZPnLlDVBKA62TTgv7mVx7rEiTU6POTI24KProiw1hlRR7
         kLVdhwSbLaVWzlB7jVkSd2BhA8W/UbJ5zfggXScNa6vxMXphTS63GOp8GEtlC/AQ+HBj
         OmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=clAxQ37OE8bsUk7gVdrKB+HDUP0KUPp+G1oPTKfKdDc=;
        b=iuWQnd0nPiHvNIqHpI+qAUaTyeDYxSKdFDgCPGytvTjyKiqZKAkGkA4msL4z1OzSdE
         lwBY0/JTAi28VARZ5aCKpf1Q/7ZL5oGg8Qi7b79328sSYpTHjEr7S1zrsoLVnzAcbj+1
         OrejoDsgmdOdsMPvLP7l3RLvc3miqqCYlDv+BQeqvcUa9Q6zickvL7APDP4INjByHfEe
         3tY3QZPiOw2srVb1K1FsPp3pGyZnO/bcmWsywryhFFcyJjizugLBGQqGJthA9aNnY6L1
         8DmtqjkSiImJGY0EeR8XHSDvZwuKy4QrkX9kTbMfHhx/xbU51oNzCYCNCgYNds9ZJIOJ
         XLIQ==
X-Gm-Message-State: APjAAAXQlalYnxCXCJbd7NwmXAiPx1M7OEFFD0f86wuSpsQME/xVAwRD
        jfXgn0opyEdlIY0G+OzrknLLS/yQN05GGA==
X-Google-Smtp-Source: APXvYqyQnKtITnfqWgUCUcIhVkLVldAY4dPREWKbnFi/I07pgvEu47PSVrY6y+2sb4PNYD5MTOQ3DA==
X-Received: by 2002:a17:902:d706:: with SMTP id w6mr46727394ply.261.1558574261594;
        Wed, 22 May 2019 18:17:41 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id u20sm34106856pfm.145.2019.05.22.18.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 18:17:40 -0700 (PDT)
Date:   Thu, 23 May 2019 09:17:23 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [A General Question] What should I do after getting Reviewed-by from
 a maintainer?
Message-ID: <20190523011723.GA15242@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
I am starting submitting patches these days and got some patches 
"Reviewed-by" from maintainers. After checking the 
submitting-patches.html, I figured out what "Reviewed-by" means. But I
didn't get the guidance on what to do after getting "Reviewed-by".
Am I supposed to send this patch to more maintainers? Or something else?
Thanks
Gen
