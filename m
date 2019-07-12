Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB66C742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA50B2084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfGLIo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 04:44:56 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:41704 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfGLIo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:44:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 13210182B0;
        Fri, 12 Jul 2019 10:44:54 +0200 (CEST)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 9KsVRFEF60Pk; Fri, 12 Jul 2019 10:44:53 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id C6087184F3;
        Fri, 12 Jul 2019 10:44:52 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4ED41E06E;
        Fri, 12 Jul 2019 10:44:52 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A93FB1E06C;
        Fri, 12 Jul 2019 10:44:52 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Fri, 12 Jul 2019 10:44:52 +0200 (CEST)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id 9CE8E1E7;
        Fri, 12 Jul 2019 10:44:52 +0200 (CEST)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 905F4802EC; Fri, 12 Jul 2019 10:44:52 +0200 (CEST)
Date:   Fri, 12 Jul 2019 10:44:52 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] printk: Do not lose last line in kmsg buffer dump
Message-ID: <20190712084452.peyiucrvoeyzzege@axis.com>
References: <20190711142937.4083-1-vincent.whitchurch@axis.com>
 <20190712080904.tab57k3rtyeaxs5z@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712080904.tab57k3rtyeaxs5z@pathway.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 10:09:04AM +0200, Petr Mladek wrote:
> The patch looks like a hack using a hole that the next cycle
> does not longer check the number of really stored characters.
> 
> What would happen when msg_print_text() starts adding
> the trailing '\0' as suggested by
> https://lkml.kernel.org/r/20190710121049.rwhk7fknfzn3cfkz@pathway.suse.cz

I did have a look at that possibility, but I didn't see how that could
work without potentially affecting userspace users of the syslog ABI.
AFAICS the suggested change in msg_print_text() can be done in one of
three ways:

 (1) msg_print_text() adds the '\0' and includes this length both when
     it estimates the size (NULL buffer) and when it actually prints:

     If we do this:
     - kmsg_dump_get_line_nolock() would have to subtract 1 from the len
       since its callers expected that len is always smaller than the
       size of the buffer.
     - The buffers given to use via the syslog interface will now include
       a '\0', potentially affecting userspace applications which use
       this ABI.
 
 (2) msg_print_text() adds the '\0', and includes this in the length
     only when estimating the size, and not when it actually prints.

     If we do this:
     - SYSLOG_ACTION_SIZE_UNREAD tries uses the size estimate to give
       userspace a count of how many characters are present in the
       buffer, and now this count will start differing from the actual
       count that can be read, potentially affecting userspace
       applications.

 (3) msg_print_text() adds the '\0', and does not include this length
     in the result at all.

     If we do this:
     - The original kmsg dump issue is not solved, since the last line
       is still lost.

> BTW: What is the motivation for this fix? Is a bug report
> or just some research of possible buffer overflows?

The fix is not attempting to fix a buffer overflow, theoretical or
otherwise.

It's a fix for a bug in functionality which has been observed on our
systems:  We use pstore to save the kernel log when the kernel crashes,
and sometimes the log in the pstore misses the last line, and since the
last line usual says why we're panicing so it's rather important not to
miss.

> The commit message pretends that the problem is bigger than
> it really is. It is about one byte and not one line.

I'm not quite sure I follow.  The current code does fail to include the
*entire* last line.

The memcpy on line #1294 is never executed for the last line because we
stop the loop because of the check on line #1289:

  1270  static size_t msg_print_text(const struct printk_log *msg, bool syslog, char *buf, size_t size)
  1271  {
  1272          const char *text = log_text(msg);
  1273          size_t text_size = msg->text_len;
  1274          size_t len = 0;
  1275  
  1276          do {
  1277                  const char *next = memchr(text, '\n', text_size);
  1278                  size_t text_len;
  1279  
  1280                  if (next) {
  1281                          text_len = next - text;
  1282                          next++;
  1283                          text_size -= next - text;
  1284                  } else {
  1285                          text_len = text_size;
  1286                  }
  1287  
  1288                  if (buf) {
  1289                          if (print_prefix(msg, syslog, NULL) +
  1290                              text_len + 1 > size - len)
  1291                                  break;
  1292  
  1293                          len += print_prefix(msg, syslog, buf + len);
  1294                          memcpy(buf + len, text, text_len);
  1295                          len += text_len;
  1296                          buf[len++] = '\n';
  1297                  } else {
  1298                          /* SYSLOG_ACTION_* buffer size only calculation */
  1299                          len += print_prefix(msg, syslog, NULL);
  1300                          len += text_len;
  1301                          len++;
  1302                  }

