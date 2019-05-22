Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2CDC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E9520881
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqi2qu9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfEVSDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:03:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37317 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVSDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:03:35 -0400
Received: by mail-qt1-f194.google.com with SMTP id o7so3497814qtp.4;
        Wed, 22 May 2019 11:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oxyDsoTHFUzofkcraRdmEa5q+RjpkJbCd1vJwf92rGQ=;
        b=hqi2qu9QuXcX8/7V3QmgW7Ddts/lKukQqbObrp8ahI2bPQFCru6WclVLN2cck931VQ
         Enw9nQID45IP6osK62fuKtfDgzjBCg2eOWGwSrDPNMMbrJMOw5EcP/FRUGoWD8gEnzoS
         68Fpv6wxlb/j0A/iNej3TRSXbsxSKVK73gBjqCN3r/RUWXz/JuoWYrNaSykr2tSpmZJA
         PWFNjj98Sfky7rBiILhy6Ks8XXX0BPJ5PkDBh8y8kvk9s486JkvzZBXoNkLF71LpNcuf
         7BkSsMkGmrC1nZTC1NTEz4kJnhXc8FQUEi6zBeflW+iFoQaov/7axzjOisgBv13ckd88
         vT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oxyDsoTHFUzofkcraRdmEa5q+RjpkJbCd1vJwf92rGQ=;
        b=qDa9rarlsCU/RIVsJgUTQJffFS5qFz9I+2omZZYGZMet75pjonNgO7elClgXdaijdg
         ZFugzS6bW6QXDVTFW4HMt7aEHTjHh8mKSdO7wbgHIhHJ6iGKi1sTjRKwEIPTtpjbQRba
         9xkZkwmJQ2AgjJTOlXbMSr7EN1IbbaUi+uPD/M3aurDWEOHSYcAJoA7MXHKnEXhoREZ/
         3NDjr0n9rm3rHfEaanWcZb628Zn9LwHsw60tM4qMtyW+CWKfPQ1dL3ZwTn2HaKg3xJAM
         jFlM4cM0oOmwIxi1yubGqFUDQnFgyp0gF52Xlnb9jdntTQZt5LH2VvWCRSzaeEsSCSy5
         kdUQ==
X-Gm-Message-State: APjAAAUFjDpe049TJuO0lyOOZMmXsLPFZk2zOYVmqVKeA7uVLIl+uAD4
        GspKmijvcjMRYwsoka4QhaU=
X-Google-Smtp-Source: APXvYqyKmrEeSIdAP/afJcXsT1L97brWPTC7k0E7pgS5w82rBXhpY6POeI9wPgwnxZzwywxGQ8gs6Q==
X-Received: by 2002:ac8:2732:: with SMTP id g47mr43323757qtg.156.1558548213971;
        Wed, 22 May 2019 11:03:33 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id o6sm12362521qtc.47.2019.05.22.11.03.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 11:03:32 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8B3B8404A1; Wed, 22 May 2019 15:03:27 -0300 (-03)
Date:   Wed, 22 May 2019 15:03:27 -0300
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH 3/3] perf record: Fix s390 missing module symbol and
 warning for non-root users
Message-ID: <20190522180327.GH30271@kernel.org>
References: <20190522144601.50763-1-tmricht@linux.ibm.com>
 <20190522144601.50763-4-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522144601.50763-4-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 22, 2019 at 04:46:01PM +0200, Thomas Richter escreveu:
> Command 'perf record' and 'perf report' on a system without kernel
> debuginfo packages uses /proc/kallsyms and /proc/modules to find
> addresses for kernel and module symbols. On x86 this works for root
> and non-root users.
> 
> On s390, when invoked as non-root user, many of the following warnings
> are shown and module symbols are missing:
> 
>     proc/{kallsyms,modules} inconsistency while looking for
>         "[sha1_s390]" module!
> 
> Command 'perf record' creates a list of module start addresses by
> parsing the output of /proc/modules and creates a PERF_RECORD_MMAP
> record for the kernel and each module. The following function call
> sequence is executed:
> 
>   machine__create_kernel_maps
>     machine__create_module
>       modules__parse
>         machine__create_module --> for each line in /proc/modules
>           arch__fix_module_text_start
> 
> Function arch__fix_module_text_start() is s390 specific. It opens
> file /sys/module/<name>/sections/.text to extract the module's .text
> section start address. On s390 the module loader prepends a header
> before the first section, whereas on x86 the module's text section
> address is identical the the module's load address.
> 
> However module section files are root readable only. For non-root the
> read operation fails and machine__create_module() returns an error.
> Command perf record does not generate any PERF_RECORD_MMAP record
> for loaded modules. Later command perf report complains about missing
> module maps.
> 
> To fix this function arch__fix_module_text_start() always returns
> success. For root users there is no change, for non-root users
> the module's load address is used as module's text start address
> (the prepended header then counts as part of the text section).

Thanks, applied.

- Arnaldo
