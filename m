Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F272C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CAD2339F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9XRegtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbfHUPgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:36:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35565 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbfHUPgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:36:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id gn20so1530127plb.2;
        Wed, 21 Aug 2019 08:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bU5dLSJ35u6Bc3f/Z8UK4KjZIowhKbGPaLIlOlO9BhQ=;
        b=e9XRegtx2T5/e+EyraTykJJsAX5TrMpT3p/QgxCT00RPnE4ToK70gJoh1Y0WFJWSLY
         zDoLyDdoWRh/QzLOGtgOgQtJcb7LD6M9ftcJ9GQNghZVgg1imiXyBlU+LtdZVry/w/lV
         4D0T7cCQiWsAolm3jmhpB6gNjToS7C/jzSSdQ6FsDO+P+oJLptCF4E/2oNt577BEiNvr
         5WZMUJnroUCxcJXbSE1+OrxidBI62E4USySFN4vCy58DtlMTYs359/raXKXTRDm1/gZN
         T7TPsvPcO6UxVhyjp7I+Fy4cQA4zapyu3Si0Kz1PDEtBPTOHwhRRb6brgDYm1MuOlwbX
         kM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bU5dLSJ35u6Bc3f/Z8UK4KjZIowhKbGPaLIlOlO9BhQ=;
        b=YJqC4Ajxp8bcHh59FAvNI/TbnG9WRiwlnCZDMMcLc/4nsXZ+zk8HT4E6TbIK+zhW+Q
         tsXgDeam+WwxjeALlsfnaJpSU+krYniANg5qlf/fK9H8P0c3dTdexosRM66PizAqGNiw
         LNYoL7DonVwVOXHTym4p1F4zHMp74aDfZrL1oSu4t92ERRflh792faHjQFMQUPiuCSC0
         hyxxnqrL4VPvkvzf8Y7fWmKIl7773LAErPjIiZjiRShyCKlOc/+JeUS5iHEjDxb8EEt+
         mvXr0BC94Oryu2YjjGEDMV2dPB7bholH283QGrIXx4Q2lcsHWnx6XJrx+OSYGK0rebJa
         hUcQ==
X-Gm-Message-State: APjAAAUE5w+8+2eQXxaoKmZTbIKIBV+oEVBTmgsDV+os8Zh9JWdgI6zg
        o4SH3eEtyoActH0LCvkRob2vOqkT
X-Google-Smtp-Source: APXvYqznq9ryDWqFwBT1mchJS5I30ZywXEQEi/az8vBCk4OtbrFfSOQOZVxLTuzTa+oAN5fc3zjogg==
X-Received: by 2002:a17:902:834c:: with SMTP id z12mr20462410pln.8.1566401799789;
        Wed, 21 Aug 2019 08:36:39 -0700 (PDT)
Received: from [192.168.43.210] (mobile-166-137-176-042.mycingular.net. [166.137.176.42])
        by smtp.gmail.com with ESMTPSA id t9sm29730588pgj.89.2019.08.21.08.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 08:36:39 -0700 (PDT)
Subject: Re: [PATCH v7 1/7] driver core: Add support for linking devices
 during device addition
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
References: <20190724001100.133423-1-saravanak@google.com>
 <20190724001100.133423-2-saravanak@google.com>
 <32a8abd2-b6a4-67df-eee9-0f006310e81e@gmail.com>
 <CAGETcx8Q27+Jnz+rHtt33muMV6U+S3cmKh02Ok_Ds_ZzfBqhrg@mail.gmail.com>
 <522e8375-5070-f579-6509-3e44fe66768e@gmail.com>
 <CAGETcx-9Bera+nU-3=ZNpHqdqKxO0TmNuVUsCMQ-yDm1VXn5zA@mail.gmail.com>
 <a4c139c1-c9d1-3e5a-f47f-cd790b42da1f@gmail.com>
 <CAGETcx-J7+d3pcArMZvO5zQbUhAhRW+1=FUf7C1fV9-QhkckBw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <915b49b5-5511-afa2-d3d6-e4ede94d40be@gmail.com>
Date:   Wed, 21 Aug 2019 08:36:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx-J7+d3pcArMZvO5zQbUhAhRW+1=FUf7C1fV9-QhkckBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/19 3:10 PM, Saravana Kannan wrote:
> On Mon, Aug 19, 2019 at 9:25 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 8/19/19 5:00 PM, Saravana Kannan wrote:
>>> On Sun, Aug 18, 2019 at 8:38 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>

< snip >

>>>
>>> 3. The supplier info doesn't always need to come from a firmware. So I
>>> don't want to limit it to that?
>>
>> If you can find another source of topology info, then I would expect
>> that another set of fwnode_operations functions would be created
>> for the info source.
> 
> The other source could just be C files in the kernel. Using fwnodes
> for that would be hacky. But let's sort (1) and (2) out first.
> 

< snip >

Just a piece of trivia.  I got curious enough about this to search.
There is a third type of fwnode, software nodes.

See commit 59abd83672f70cac4b6bf9b237506c5bc6837606 for a description.

-Frank
