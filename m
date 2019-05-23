Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D37C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9162A2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="aKawysc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbfEWUt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 16:49:29 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:45388 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731462AbfEWUt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 16:49:29 -0400
Received: by mail-pf1-f172.google.com with SMTP id s11so3885260pfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 13:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=BQAwLzyZHUTUA9C3I6GaYYp03v/RFuFPqVYAXDj/LaE=;
        b=aKawysc0V3G9cMZQs9o9HXnwZZG4jR8E0LAYted1+NjTq3GTsEvPNFXMDLsKCGfhLg
         DpKyBuoUNFmGK+7ATsRp+BLmC3U401yuvEaGgzpqekXN6TH0re2YAMpv/kdzHfX9dvRq
         tcwQ4skXKrRKlr8eKZapFsDEITLAMOOnu6XzOe9kv3+5JmCfSQj3kssU9wH2Mo6w44YL
         xCT95P/aAys0PXzQqXEdg9AR0383BpZHVhyMr4V9yi9JoF3QUyMju1ymrepiYnejGZcO
         /5dKjXa/MvGM3qf72OdyT5ZkzToG/l/ogbAyZMPGzNIa+kobEfk7YQgpTMPFimwz5bsG
         Re2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=BQAwLzyZHUTUA9C3I6GaYYp03v/RFuFPqVYAXDj/LaE=;
        b=C0Fp6ubQL5Bn29SUUmy4LgM0AfOWHBeOVjAa094D7/muZbQbzHBsagWdOl9ebYwAcu
         ZgZvv8ZL3fCx2RHDmbzBBn3xaepWFMX+i5/eUaoWnR12fr6XmaLxsFKoRhOddf5m5gEB
         iQbaQ5g7KQb4duF3i4jCd8j85ueBvjf6pFdj0nh9+RBoVN3isDI+jxiuy2DIiSOkFiJ8
         7zgRrJ8LjCUT0mNi1B9K4TRio59NV1QOYBbnzhz/MdVi/DRfD4JXdWswyWZ/66zd9W0q
         W/NKVxqt9Csttp3jlTKkKImAE2APHnc7T+UPdcakn6cXpCpX7Y0jKGaMHWYsyQQSsgqk
         J1PA==
X-Gm-Message-State: APjAAAVifIxgE9np8oiEzHgKTpNcIzizNr8ZGP8gOnmTt86Na2l/bZty
        eq7fU5Vge/xePDrXhhdZoHLw3XCy3G1g4g==
X-Google-Smtp-Source: APXvYqw5Pck4d1+xCnVCIAOEFNCMYuRkWYzl/96/Hj2JFfsn1S6gWQ4S5fh3P8WJVWvq0lx9Zys4qg==
X-Received: by 2002:a65:530d:: with SMTP id m13mr5564193pgq.68.1558644568127;
        Thu, 23 May 2019 13:49:28 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.googlemail.com with ESMTPSA id j97sm210977pje.5.2019.05.23.13.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 13:49:27 -0700 (PDT)
To:     stable <stable@vger.kernel.org>
From:   Mark Salyzyn <salyzyn@android.com>
Subject: Please cherrypick 592acbf1682128 to 3.18.y and 4.4.y
Cc:     LKML <linux-kernel@vger.kernel.org>
Message-ID: <6f545e7c-fda8-4bec-33fc-283ebf492372@android.com>
Date:   Thu, 23 May 2019 13:49:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cherry pick security-related fix 
592acbf16821288ecdc4192c47e3774a4c48bb64 ("ext4: zero out the unused 
memory region in the extent tree block") to 3.18.y and 4.4.y

The cherry-pick is clean and requires no back-porting. Is already 
present in 4.9.y+

Signed-off-by: Mark Salyzyn<salyzyn@android.com>

To: stable <stable@vger.kernel.org> # 3.18.y 4.4.y

Cc: LKML <linux-kernel@vger.kernel.org>

