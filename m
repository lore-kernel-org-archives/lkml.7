Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D25C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3ACA2148D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556056940;
	bh=FhArrED8BN1Xyq63DfhfXXDjR4FiTX8CluznIcw05EE=;
	h=From:Subject:To:Cc:References:Date:In-Reply-To:List-ID:From;
	b=b+E376Va1uexI5sSO6+HBUN3R/lUnagZDgGw8x9zEnC2iTewr2JFk+X8VhYE9qtiz
	 7CAY5w3xvl3SinD20uaZQJbPzaGhd4GgdymWAlYCWmoxNXfLfhGqvOij2M0EEJNxEW
	 jYIzTN11efbMGq85aK3sWS6Q4uF62W9fGCbWswpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfDWWCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:02:19 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35513 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfDWWCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:02:18 -0400
Received: by mail-yw1-f65.google.com with SMTP id d132so6211810ywa.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X7O0KvCE0YFyN+hnadzgbU45Yw3YJoAenM1XoLAT0HI=;
        b=Ore60regilhYPTumjPGcdSQ8h67wfziKlp4dDvZfGi4qqLVt29S2XE+ZbkGX2/hRqs
         to885yPhuhPdgXId181NYPtECGUlQ9j3BWD/1cv/hE37+hZavXBl5LQxi87CZsgIg+sa
         abASnrJEjkqutuAilDjkKpB0QkOlMTMU7zpwVzDvpcGexQYtF92WJS0OsKfJvn1Vp68E
         DHAYsO5a2x+mz/wxkI73IbPOcdteRuZchV4TAh3LmJ6L4cg3dkglhzFo2qLfC2Kfq3xG
         AbQ5OCdt3cu3yzJ4i5GAhQa8ep/ctCto7Gxkt+mWuwIkTlmVDp+72QPuqsow1vFazoW6
         2V1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X7O0KvCE0YFyN+hnadzgbU45Yw3YJoAenM1XoLAT0HI=;
        b=eMnq068yFWGP3GJyJ6jpTOULepZXek1B1jIiDWRK4w8jMZMDDUkE7AqgjCwVbnkJIg
         db28WbRseW8n9Jv3Ponhqu9WRCcRAZk2VtUZBQIyRNMEtPdLtBaYgAK9CZ60/2aG2lrC
         M+UNaZGJ+7jFZqLVNsQtyg44BPzea5X4xpkWWYphvAca2LHRXVymjHSRnYzo9T37cQ44
         LuYSrdiifl9EaickeLx+9ORmUaUVebbyy0adlNss0ye2LBy9V08K8er+N8uhfZzqn+ws
         rRAOar5VZ8mTve8OZ+8sJGf8XrYybuf5PMBL8huZi3qj03o9JUpJfENyfw+DEAfeutoW
         Vt1A==
X-Gm-Message-State: APjAAAXPTEoLjv2DeVH08dia5bEQnvBt+1DfJWp/0+g78m1Z7weSsLST
        lTxTwRBW+//hNPHWVwDFMv8=
X-Google-Smtp-Source: APXvYqwx1GQk4tPF6gM9vfCKKu9XV3JvzM5WhcLVw8jYUQQM528SH15udcU2B+a7vI+UORaJyY6DZQ==
X-Received: by 2002:a81:1693:: with SMTP id 141mr23785247yww.448.1556056937702;
        Tue, 23 Apr 2019 15:02:17 -0700 (PDT)
Received: from [192.168.1.74] (75-58-59-55.lightspeed.rlghnc.sbcglobal.net. [75.58.59.55])
        by smtp.gmail.com with ESMTPSA id j83sm5618655ywj.93.2019.04.23.15.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:02:17 -0700 (PDT)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v5 0/5] init: Do not select DEBUG_KERNEL by default
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
References: <20190413224438.10802-1-okaya@kernel.org>
 <CAGXu5jLRnq1WeDtMSwE_qnve_O9+GiZd4m=N=_1rBidwRwmeJg@mail.gmail.com>
Message-ID: <ff84544e-33f8-e6aa-48b3-2f786ff15dfc@kernel.org>
Date:   Tue, 23 Apr 2019 18:02:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLRnq1WeDtMSwE_qnve_O9+GiZd4m=N=_1rBidwRwmeJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/2019 11:55 PM, Kees Cook wrote:
> Thanks! This looks good to me. For the series:
> 
> Reviewed-by: Kees Cook<keescook@chromium.org>
> 
> Andrew, can you take these from lkml, or should the series get resent
> directly to you? I think you might be the best to carry this?

Where do we stand on this?

Anything for me to do, here?
