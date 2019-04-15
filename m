Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B64BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC6B2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clAw7PEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfDOPlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:41:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32937 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfDOPlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:41:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id t16so8766746plo.0;
        Mon, 15 Apr 2019 08:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=03U2+gNC/tIGz//LfXqwAH1STf4MB9cTPsC4LtWU1hs=;
        b=clAw7PEKP+T+IfxwlxZTrhucaaezcIpRoc0B707Xfji5JrW5EEbGpPDhuOVRi7dj2t
         hfwzbD6RbHabaoqnTEUVUvSzwWZjj/K2++1ytJ06c/pNgrdRsU7S9W32ihW9JRzoON9o
         LuIZFV6iTeqeDEzvuDw1xrhTpB8bXsdXHZOEJ1TLP5zoHSKRxOWpz/q1SHzJjblJaKX2
         uyLRXErKJoYYOb9MJWRZs2H88B2GN8GmmGIRl1cV6L+PHCHu9S+IPYvilg80O6wsvXTz
         jXWnhyz4ktOHfG6YXOwHGeUtMKGIP2WYGy0+tcAqIaEXILVSIu0Q4jPJjvxJVB2uEc8T
         IhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=03U2+gNC/tIGz//LfXqwAH1STf4MB9cTPsC4LtWU1hs=;
        b=ATf+0TuyJtFAqvCt+PqxbJuCDtqBt/5j/n4o81kwhc5dKQYWI/McWWw5KjojvCuHLg
         UR0+7gTXyop5bunxgc4LfRAcmpc+zO2rmhlw6c7/EimNjvc7fBI1qU0hD8DGwM9+lBtE
         MimBfsjCvyM6ww1iwVvZnssJEif757p1XKtk8d1s5uGDvA/abDHKhQaYW35EIfHJiAGP
         5+0uwHJpqlGf1Ud7NNkwg3hrdYgR2ctFT9vhxRlXTJ3/ia7UhcHiaialG+JpQhvTBSlm
         M9zkTGv8ifidFdpMR8YC+AQto2ttwjvz2pqWE4pu6IeB9FTon1UzA4yWXX6VDxHxgNMq
         s07w==
X-Gm-Message-State: APjAAAVeWSBAfe3pKIxjLWMZK+m35Kuc1q1UJwtjIaO3Z5JfJ4jlbx6d
        EH6lQnfWeLHCTrjBSXFCEvdnLfjp
X-Google-Smtp-Source: APXvYqz39iqJRTwlyGeSLEpp91C4BX6W6y9xH6hv9V9M6k16pwsRaq01nE2WBm3oZuE7fINZR4ZQdA==
X-Received: by 2002:a17:902:b60d:: with SMTP id b13mr77026589pls.100.1555342914669;
        Mon, 15 Apr 2019 08:41:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y191sm23409547pgd.78.2019.04.15.08.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 08:41:53 -0700 (PDT)
Date:   Mon, 15 Apr 2019 08:41:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Patrick Venture <venture@google.com>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ir38064) delete incorrect line
Message-ID: <20190415154151.GA7292@roeck-us.net>
References: <20190415141728.133110-1-venture@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415141728.133110-1-venture@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 07:17:28AM -0700, Patrick Venture wrote:
> Delete line indicating the datasheet was not publicly available.  This
> line was originally present as a default during the write-up and was
> subsequently not removed once the datasheet was located.
> 
> Signed-off-by: Patrick Venture <venture@google.com>

Applied.

Thanks,
Guenter
