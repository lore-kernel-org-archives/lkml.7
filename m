Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1504FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B8520823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="QQmlbfBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbfCZNLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:11:39 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39217 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZNLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:11:38 -0400
Received: by mail-ed1-f67.google.com with SMTP id p20so10219576eds.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 06:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KyICKHawodi0q5vRc842R7ZLBQGvYXISdjlGH9osZLw=;
        b=QQmlbfBscHRulIMYmBScbnb4HHYkLGzyAzq6HkA6BkvfzqGXOdOEQ9lBmZ/Rx8ki4V
         12uEKsYsILfGgoDVXUwKkYToADl6L1hKMCAiZcPaKagJYlA140AYaP/1mn+mn0epOuW/
         wI2HofnUffPc4ml1rbXGV0udTFZNZDKNPJH78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KyICKHawodi0q5vRc842R7ZLBQGvYXISdjlGH9osZLw=;
        b=RG2B67P2fXfrVbYkw6J3piqLEGlKUL7KRd2TRLqTS+6DlF++1J4vNkS6rha4oMIVq+
         IadG58ATyMgbzCiiUX6U/Skz1FEXb8ZXS+OUZd3fdR/S9thdvh1YrpEZCgCTNEq2D/sA
         excnHpmlrABOw9z8lat9w9fsiUwur63UNjGQyrIycEka/vg1gDr2YFHANoZZtGT47e+8
         0CcV19LeUu3NBox25+szFIXOP0jiYq5P/eHQTPdF9a3nzVHTyJ2oknh7hmLgDJTDmcLG
         uLSyv3Qu/FCp2O0Qnlsyj/xEyEzb2eRTVbfc7T8SwEdI/Y8t7Arq5+juiP11fBR/Or05
         BLkw==
X-Gm-Message-State: APjAAAXaUSP70GHKdJmeLiBdPR2JKtWj4JDSWZWmUSeSxBncC2gq08Mo
        3V5mK2EmFdFF2jk+Zmti66MiRw==
X-Google-Smtp-Source: APXvYqzyWzcBh8HAhCQD5mKeOhzu6mAiSee/yF+impIUD7ynfTbvdvQFWXKv+v8NF5ME9//yj/cttA==
X-Received: by 2002:aa7:c250:: with SMTP id y16mr16828735edo.238.1553605896843;
        Tue, 26 Mar 2019 06:11:36 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id c7sm971311edt.70.2019.03.26.06.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 06:11:36 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-7-sakari.ailus@linux.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <8c6accab-9e0c-c2d4-ce93-ea3ede60f34e@rasmusvillemoes.dk>
Date:   Tue, 26 Mar 2019 14:11:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190326124106.27694-7-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2019 13.41, Sakari Ailus wrote:
> Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> support printing full path of the node, including its name ("f") and only
> the node's name ("P") in the printk family of functions. The two flags
> have equivalent functionality to existing %pOF with the same two modifiers
> ("f" and "P") on OF based systems. The ability to do the same on ACPI
> based systems is added by this patch.
> 
>  
> +static noinline_for_stack
> +char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
> +		    struct printf_spec spec, const char *fmt)
> +{
> +	const char * const modifiers = "fP";
> +	struct printf_spec str_spec = spec;
> +	char *buf_start = buf;
> +	bool pass;
> +
> +	str_spec.field_width = -1;
> +
> +	if ((unsigned long)fwnode < PAGE_SIZE)
> +		return string(buf, end, "(null)", spec);
> +
> +	/* simple case without anything any more format specifiers */
> +	fmt++;
> +	if (fmt[0] == '\0' || strcspn(fmt, modifiers) > 0)
> +		fmt = "f";
> +
> +	for (pass = false; strspn(fmt, modifiers); fmt++, pass = true) {
> +		if (pass) {
> +			if (buf < end)
> +				*buf = ':';
> +			buf++;
> +		}
> +
> +		switch (*fmt) {
> +		case 'f':	/* full_name */
> +			buf = fwnode_gen_full_name(fwnode, buf, end);
> +			break;
> +		case 'P':	/* name */
> +			buf = string(buf, end, fwnode_get_name(fwnode),
> +				     str_spec);
> +			break;
> +		default:
> +			break;
> +		}
> +	}

This seems awfully complicated. Why would anyone ever pass more than one
of 'f' and 'P'? Why not just

switch(*fmt) {
case 'P':
   ...
case 'f':
default:
   ...
}

which avoids the loop and the strcspn. Or, drop the default: case and
don't have logic at all for falling back to 'f' if neither is present.

> +	return widen_string(buf, buf - buf_start, end, spec);
> +}
> +
>  /*
>   * Show a '%p' thing.  A kernel extension is that the '%p' is followed
>   * by an extra set of alphanumeric characters that are extended format
> @@ -1936,6 +1978,10 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
>   *                  F device node flags
>   *                  c major compatible string
>   *                  C full compatible string
> + * - 'fw[fP]'	For a firmware node (struct fwnode_handle) pointer
> + *		Without an option prints the full name of the node
> + *		f full name
> + *		P node name, including a possible unit address
>   * - 'x' For printing the address. Equivalent to "%lx".
>   *
>   * ** When making changes please also update:
> @@ -2060,6 +2106,16 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  			return device_node_string(buf, end, ptr, spec, fmt + 1);
>  		}
>  		break;
> +	case 'f':
> +		switch (fmt[1]) {
> +		case 'w':
> +			return fwnode_string(buf, end, ptr, spec, fmt + 1);

Why not pass fmt+2; we know that fmt+1 points at a 'w'. Just to avoid
doing the fmt++ inside fwnode_string().

Rasmus
