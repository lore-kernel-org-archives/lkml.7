Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE60C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 05:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15A520678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 05:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgAIFNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 00:13:13 -0500
Received: from mga14.intel.com ([192.55.52.115]:13929 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgAIFNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 00:13:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 21:13:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,412,1571727600"; 
   d="scan'208";a="223761944"
Received: from liujing-mobl1.ccr.corp.intel.com (HELO [10.238.130.147]) ([10.238.130.147])
  by orsmga003.jf.intel.com with ESMTP; 08 Jan 2020 21:13:10 -0800
From:   "Liu, Jing2" <jing2.liu@linux.intel.com>
Subject: Re: [virtio-dev][PATCH v1 1/2] virtio-mmio: Add MSI and different
 notification address support
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtio-dev@lists.oasis-open.org, slp@redhat.com,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
References: <1576855504-34947-1-git-send-email-jing2.liu@linux.intel.com>
 <20200106161836.GB350142@stefanha-x1.localdomain>
Message-ID: <f691fb60-8f59-e827-6a5f-569db29e0a39@linux.intel.com>
Date:   Thu, 9 Jan 2020 13:13:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200106161836.GB350142@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/7/2020 12:18 AM, Stefan Hajnoczi wrote:
> On Fri, Dec 20, 2019 at 11:25:03PM +0800, Jing Liu wrote:
>> Upgrade virtio-mmio to version 3, with the abilities to support
>> MSI interrupt and notification features.
>>
>> The details of version 2 will be appended as part of legacy interface
>> in next patch.
> Cool, MSI is useful.  Not a full review, but some comments below...

Hi Stefan,

Thanks for reviewing patches! Glad to see that MSI is welcome.

>> Signed-off-by: Jing Liu<jing2.liu@linux.intel.com>
>> Signed-off-by: Chao Peng<chao.p.peng@linux.intel.com>
>> Signed-off-by: Zha Bin<zhabin@linux.alibaba.com>
>> Signed-off-by: Liu Jiang<gerry@linux.alibaba.com>
>> ---
>>   content.tex  | 191 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
>>   msi-status.c |   5 ++
>>   2 files changed, 163 insertions(+), 33 deletions(-)
>>   create mode 100644 msi-status.c
>>
>> diff --git a/content.tex b/content.tex
>> index d68cfaf..eaaffec 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -1597,9 +1597,9 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>>     }
>>     \hline
>>     \mmioreg{Version}{Device version number}{0x004}{R}{%
>> -    0x2.
>> +    0x3.
>>       \begin{note}
>> -      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}) used 0x1.
>> +      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}) used 0x1 or 0x2.
> "Legacy devices" refers to pre-VIRTIO 1.0 devices.  0x2 is VIRTIO 1.0
> and therefore not "Legacy".  I suggest the following wording:
>
>        Legacy devices (see \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}) used 0x1.
> +     VIRTIO 1.0 and 1.1 used 0x2.
Thanks for the guide.
> Did you consider using a transport feature bit instead of changing the
> device version number?  Feature bits allow more graceful compatibility:
> old drivers will continue to work with new devices and new drivers will
> continue to work with old devices.

Yes, we considered using a feature bit from 24~37 or above, while a 
concern is that,

the device which uses such bit only represents the behavior of mmio 
transport layer but not common behavior

of virtio device. Or am I missing some "transport" feature bit range?


>>       \end{note}
>>     }
>>     \hline
>> @@ -1671,25 +1671,23 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>>       accesses apply to the queue selected by writing to \field{QueueSel}.
>>     }
>>     \hline
>> -  \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
>> -    Writing a value to this register notifies the device that
>> -    there are new buffers to process in a queue.
>> +  \mmioreg{QueueNotify}{Queue notifier}{0x050}{RW}{%
>> +    Reading from the register returns the virtqueue notification configuration.
>>   
>> -    When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
>> -    the value written is the queue index.
>> +    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Notification Address}
>> +    for the configuration format.
>>   
>> -    When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
>> -    the \field{Notification data} value has the following format:
>> +    Writing when the notification address calculated by the notification configuration
>> +    is just located at this register.
> I don't understand this sentence.  What happens when the driver writes
> to this register?

We're trying to define the notification mechanism that, driver MUST read 
0x50 to get the notification configuration

and calculate the notify address. The writing case here is that, the 
notify address is just located here e.g. notify_base=0x50, notify_mul=0.


>>   
>> -    \lstinputlisting{notifications-le.c}
>> -
>> -    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}
>> -    for the definition of the components.
>> +    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Available Buffer Notifications}
>> +    to see the notification data format.
>>     }
>>     \hline
>>     \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
>>       Reading from this register returns a bit mask of events that
>> -    caused the device interrupt to be asserted.
>> +    caused the device interrupt to be asserted. This is only used
>> +    when MSI is not enabled.
>>       The following events are possible:
>>       \begin{description}
>>         \item[Used Buffer Notification] - bit 0 - the interrupt was asserted
>> @@ -1703,7 +1701,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>>     \mmioreg{InterruptACK}{Interrupt acknowledge}{0x064}{W}{%
>>       Writing a value with bits set as defined in \field{InterruptStatus}
>>       to this register notifies the device that events causing
>> -    the interrupt have been handled.
>> +    the interrupt have been handled. This is only used when MSI is not enabled.
>>     }
>>     \hline
>>     \mmioreg{Status}{Device status}{0x070}{RW}{%
>> @@ -1762,6 +1760,31 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>>       \field{SHMSel} is unused) results in a base address of
>>       0xffffffffffffffff.
>>     }
>> +  \hline
>> +  \mmioreg{MsiStatus}{MSI status}{0x0c0}{R}{%
>> +    Reading from this register returns the global MSI enable/disable status and maximum
>> +    number of virtqueues that device supports.
>> +    \lstinputlisting{msi-status.c}
>> +  }
> Why is it necessary to combine the number of virtqueues and global
> MSI enable/disable into a single 16-bit field?

Originally, we want this 16-bit Read-Only, so we put some RO things 
together and separate

enable setting command to next register.

> virtio-mmio uses 32-bit registers.  It doesn't try hard to save register
> space so it's strange to do it here (11-bit number of virtqueue field
> but 32-bit QueueSel field).

In order to improve performance/save register space,  we combine some 
data together.

For example, combine MSI cmd operator (e.g. enable/disable, vector 
setup) with argument (e.g. 1/0,  queue index).

But it seems we miss the consistency with QueueSel.  So do you think if 
the max queue number should be 32-bit,

which means it must be the same with QueueSel? If so, I guess we need 
some re-organization. :)

>
>> +  \hline
>> +  \mmioreg{MsiCmd}{MSI command}{0x0c2}{W}{%
>> +    The driver writes to this register with appropriate operators and arguments to
>> +    execute MSI command to device.
>> +    Operators supported is setting global MSI enable/disable status
>> +    and updating MSI configuration to device.
> If the global MSI enable/disable state is written in this register,
> consider making this register readable too so the global MSI
> enable/disable state can be read from it.

Read enable/disable state is in 0x0c0.

Thanks,

Jing


