Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AADC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0025420842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfCEQKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:10:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:37468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbfCEQKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:10:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7F7AAC6E;
        Tue,  5 Mar 2019 16:10:12 +0000 (UTC)
Subject: Re: [PATCH v2 5/7] perf script python: add Python3 support to
 intel-pt-events.py
From:   Tony Jones <tonyj@suse.de>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
References: <20190302011903.2416-1-tonyj@suse.de>
 <20190302011903.2416-6-tonyj@suse.de>
 <6fe06c75-5f98-4829-e139-af2bfcda24f3@intel.com>
 <dfa719d4-0d9e-ad08-536f-17b3da116b19@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=tonyj@suse.de; prefer-encrypt=mutual; keydata=
 mQGiBEkQmbwRBACDch7wo/RzlNt2HA8jLICsO2w8yOkJ7UTzHYNn3Q83Ro0qev2KokfE3EDw
 il+vam9CDR7jIDmswHqaMe0/O+UnZtO5PlDgylZcrwNwbBzHfm/KGejbi1RBGAoETrvcfwGi
 w83bR/aDnoRXY5Ho1uphQ05/065EMpbJOOBdn9qQ4wCgv2Q6C/QeYDGsxJPRO+20nLu5K00D
 /Rde4OTZ5biM+vb6ObTmgPNeiMrTwGpMokN7audIl7njwvD+lYrlgQjmDzcaPFz29rYWwT7g
 6t6hcFgjpU1he/v3qxeQlTJoi2+u5Mqj42z//49h6DqNjT859Z/6h5IwKBo/EZC17iBIlS2G
 VXAstNiZASGiaIlONozWJ/GSjUaRA/9wZTV1nXF/+xX+qmc7SvTg1w6jWyjxVumQLoq2SeA4
 1Sy5X2IATkAGCCjbeoQGnFdbOnHRSJdlTazObgwreqGPlPnIROpr9QESkfxsaCkDiZfpl0xk
 6X069QMZBEwGAWILHYXL9UqlOjniZaU2BkVA11JEdBhyQorC8T/ji1edc7QaVG9ueSBKb25l
 cyA8dG9ueWpAc3VzZS5kZT6IYAQTEQIAIAUCSRCZvAIbAwYLCQgHAwIEFQIIAwQWAgMBAh4B
 AheAAAoJELFYWyEf4koXGmYAoKCnbv9dhAB2vR6IvSJem1ws4HpfAJ9ZqTKiXcogBGfTPaJR
 GI9QhVUieLkCDQRJEJm8EAgAzr9Zd3v7B10ODtVc7XxbMe3W6o1FdClL9ZIgLv61zhWctafK
 DMu/MUSvxmYFq00pecD/SfX8oxArA02+sQ2E+/Zb4J7NAWIAxCfmy7VE0wDBrZH/hBapIx/L
 gVqYfZ9Rw+a4FXrlk1y8oQCwhvj+kWrm7V7olR0aPOy1NFGNUyTFSMj+pbmxiNOXdCxVUQe3
 UE1k9yA+mILjyaRanwkiCLCjNvRPL88Q017BdhVBWZmz8qhwXN/RrjCcDHsPX5O0ev68MLyu
 sh5mfukuvCqzW1Y3Ql+iwfwEw5lNmQGdoV9csg7JP7saDicSFO2KcZvMbvDMqtPFipdF5UWo
 fZKZ3wADBQf/b5cVNyb5i8QI0G7BPGBNn4VlQX5n66TsPBnrRNOi3MhTTVEBCp8s+jqUjJjX
 EjjA+O4hIm7Qqdsozurw7GlcQ0A06dIzO/1RUglZZMoC0JL43ZQmJ+3+yFrLjWgGH6ev6AOb
 YLH7ZujgAB5n0Hy2ZIChzsKLKbHptFtBvpDKB8updq+GunsY4oN3wGa67h9sHqDvjyp64Czg
 n8G5uGLwx3f/edbECKz5kPUSzChEk3suK742SEP01v4ra5WX88Hn81NjGByQMz9acJLdC7Ff
 LzXvbNa0KgvDaSllYfsJIoGCz3eKVOuTWXOiaEIKuy833+3mr2PulLCyLKysAEddKohJBBgR
 AgAJBQJJEJm8AhsMAAoJELFYWyEf4koXhgQAn1EGATLZPS53At9t+p3S8BkNI9yRAJ9A0OmL
 liv+rwEesYGlGeGNaKHTJw==
Message-ID: <18913237-75f2-731b-940d-1fccc43d1b4a@suse.de>
Date:   Tue, 5 Mar 2019 08:10:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <dfa719d4-0d9e-ad08-536f-17b3da116b19@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/19 7:02 AM, Tony Jones wrote:

> I tested the patch on a Skylake system but it was not connected to our standard
> network so I had to move files manually.  It seems I managed to somehow mess up
> and not attach the correct patch :(

Sure enough, I managed to attach the wrong patch. Sorry. I'll attach revised (v3) 
to this thread as the change is trivial.

I am seeing a lot of "instruction trace errors" on this Skylake system.  I see them
using Python2 without any of the changes.  I've not looked at this.

Output of v3.

# head /proc/cpuinfo 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 94
model name	: Intel(R) Xeon(R) CPU E3-1240 v5 @ 3.50GHz
stepping	: 3
microcode	: 0xc6
cpu MHz		: 1600.887
cache size	: 8192 KB
physical id	: 0

# ldd /tmp/perf/bin/perf | grep python
	libpython3.6m.so.1.0 => /usr/lib64/libpython3.6m.so.1.0 (0x00007fd8fdaae000)

# /tmp/perf/bin/perf script report intel-pt-events -i /tmp/perf.data | tail -20
         swapper     0/0     [006]     17424.535324338     cbr:  27  freq: 2703 MHz  ( 77%)                0 [unknown] ([unknown])
            perf 20899/20899 [003]     17424.535324363     cbr:  27  freq: 2703 MHz  ( 77%)                0 [unknown] ([unknown])
         swapper     0/0     [004]     17424.535324387     cbr:  27  freq: 2703 MHz  ( 77%)                0 [unknown] ([unknown])
         swapper     0/0     [000]     17424.535324867     cbr:  27  freq: 2703 MHz  ( 77%)                0 [unknown] ([unknown])
         swapper     0/0     [006]     17424.543315376     cbr:  24  freq: 2403 MHz  ( 69%)                0 [unknown] ([unknown])
            perf 20899/20899 [003]     17424.699315686     cbr:  16  freq: 1602 MHz  ( 46%)                0 [unknown] ([unknown])
         swapper     0/0     [006]     17424.714915068     cbr:  16  freq: 1602 MHz  ( 46%)                0 [unknown] ([unknown])
         swapper     0/0     [005]     17424.779321732     cbr:   9  freq:  901 MHz  ( 26%)                0 [unknown] ([unknown])
         swapper     0/0     [001]     17424.779322738     cbr:   9  freq:  901 MHz  ( 26%)                0 [unknown] ([unknown])
         swapper     0/0     [003]     17424.903321958     cbr:   9  freq:  901 MHz  ( 26%)                0 [unknown] ([unknown])
         swapper     0/0     [000]     17425.099316258     cbr:  16  freq: 1602 MHz  ( 46%)                0 [unknown] ([unknown])
         swapper     0/0     [003]     17425.107316167     cbr:  16  freq: 1602 MHz  ( 46%)                0 [unknown] ([unknown])
         swapper     0/0     [004]     17425.519574381     cbr:  16  freq: 1602 MHz  ( 46%)                0 [unknown] ([unknown])
         swapper     0/0     [001]     17425.519796998     cbr:  16  freq: 1602 MHz  ( 46%)                0 [unknown] ([unknown])
         swapper     0/0     [002]     17425.519828095     cbr:  16  freq: 1602 MHz  ( 46%)                0 [unknown] ([unknown])
         swapper     0/0     [005]     17425.519897417     cbr:  16  freq: 1602 MHz  ( 46%)                0 [unknown] ([unknown])
         swapper     0/0     [007]     17425.519936473     cbr:  16  freq: 1602 MHz  ( 46%)                0 [unknown] ([unknown])
Warning:
260 instruction trace errors
End
