Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5880FC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0C7227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfLTHp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 02:45:58 -0500
Received: from mga05.intel.com ([192.55.52.43]:40540 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfLTHp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:45:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 23:45:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,335,1571727600"; 
   d="scan'208";a="213499180"
Received: from hyperv-sh3.bj.intel.com ([10.240.193.95])
  by fmsmga008.fm.intel.com with ESMTP; 19 Dec 2019 23:45:55 -0800
From:   Jing Liu <jing2.liu@linux.intel.com>
To:     virtio-dev@lists.oasis-open.org
Cc:     slp@redhat.com, linux-kernel@vger.kernel.org,
        Jing Liu <jing2.liu@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Subject: [virtio-dev][PATCH v1 2/2] virtio-mmio: Append version 2 interface
Date:   Fri, 20 Dec 2019 23:25:04 +0800
Message-Id: <1576855504-34947-2-git-send-email-jing2.liu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576855504-34947-1-git-send-email-jing2.liu@linux.intel.com>
References: <1576855504-34947-1-git-send-email-jing2.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2 needs to be appended together with version 1 as legacy
interface since we introduce the latest version.

Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
---
 content.tex | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 117 insertions(+), 6 deletions(-)

diff --git a/content.tex b/content.tex
index eaaffec..faf74de 100644
--- a/content.tex
+++ b/content.tex
@@ -2047,18 +2047,129 @@ \subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Options /
 
 \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}
 
-The legacy MMIO transport used page-based addressing, resulting
+\subsubsection{Version 2}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Version 2}
+
+The version 2 MMIO transport used single interrupt number and signel notification address,
+resulting in a slightly different control register layout, the device initialization and
+interrupt event configuration procedure from later version.
+
+Table \ref{tab:Virtio Trasport Options / Virtio Over MMIO / Version 2 MMIO Device Register Layout}
+presents control registers layout, omitting
+descriptions of registers which did not change their function
+nor behaviour:
+
+\begin{longtable}{p{0.2\textwidth}p{0.7\textwidth}}
+  \caption {Version 2 MMIO Device Register Layout}
+  \label{tab:Virtio Trasport Options / Virtio Over MMIO / Version 2 MMIO Device Register Layout} \\
+  \hline
+  \mmioreg{Name}{Function}{Offset from base}{Direction}{Description}
+  \hline
+  \hline
+  \endfirsthead
+  \hline
+  \mmioreg{Name}{Function}{Offset from the base}{Direction}{Description}
+  \hline
+  \hline
+  \endhead
+  \endfoot
+  \endlastfoot
+  \mmioreg{MagicValue}{Magic value}{0x000}{R}{}
+  \hline
+  \mmioreg{Version}{Device version number}{0x004}{R}{Device returns value 0x2.}
+  \hline
+  \mmioreg{DeviceID}{Virtio Subsystem Device ID}{0x008}{R}{}
+  \hline
+  \mmioreg{VendorID}{Virtio Subsystem Vendor ID}{0x00c}{R}{}
+  \hline
+  \mmioreg{DeviceFeatures}{Flags representing features the device supports}{0x010}{R}{}
+  \hline
+  \mmioreg{DeviceFeaturesSel}{Device (host) features word selection.}{0x014}{W}{}
+  \hline
+  \mmioreg{DriverFeatures}{Flags representing device features understood and activated by the driver}{0x020}{W}{}
+  \hline
+  \mmioreg{DriverFeaturesSel}{Activated (guest) features word selection}{0x024}{W}{}
+  \hline
+  \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{}
+  \hline
+  \mmioreg{QueueNumMax}{Maximum virtual queue size}{0x034}{R}{}
+  \hline
+  \mmioreg{QueueNum}{Virtual queue size}{0x038}{W}{}
+  \hline
+  \mmioreg{QueueReady}{Virtual queue ready bit}{0x044}{RW}{}
+  \hline
+  \mmioreg{QueueNotify}{Queue notifier}{0x050}{RW}{%
+    Writing a value to this register notifies the device that
+    there are new buffers to process in a queue.
+
+    When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
+    the value written is the queue index.
+
+    When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
+    the \field{Notification data} value has the following format:
+
+    \lstinputlisting{notifications-le.c}
+
+    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}
+    for the definition of the components.
+  }
+  \hline
+  \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
+    Reading from this register returns a bit mask of events that
+    caused the device interrupt to be asserted.
+    The following events are possible:
+    \begin{description}
+      \item[Used Buffer Notification] - bit 0 - the interrupt was asserted
+        because the device has used a buffer
+        in at least one of the active virtual queues.
+      \item [Configuration Change Notification] - bit 1 - the interrupt was
+        asserted because the configuration of the device has changed.
+    \end{description}
+  }
+  \hline
+  \mmioreg{InterruptACK}{Interrupt acknowledge}{0x064}{W}{%
+    Writing a value with bits set as defined in \field{InterruptStatus}
+    to this register notifies the device that events causing
+    the interrupt have been handled.
+  }
+  \hline
+  \mmioreg{Status}{Device status}{0x070}{RW}{}
+  \hline
+  \mmiodreg{QueueDescLow}{QueueDescHigh}{Virtual queue's Descriptor Area 64 bit long physical address}{0x080}{0x084}{W}{}
+  \hline
+  \mmiodreg{QueueDriverLow}{QueueDriverHigh}{Virtual queue's Driver Area 64 bit long physical address}{0x090}{0x094}{W}{}
+  \hline
+  \mmiodreg{QueueDeviceLow}{QueueDeviceHigh}{Virtual queue's Device Area 64 bit long physical address}{0x0a0}{0x0a4}{W}{}
+  \hline
+  \mmioreg{SHMSel}{Shared memory id}{0x0ac}{W}{}
+  \hline
+  \mmiodreg{SHMLenLow}{SHMLenHigh}{Shared memory region 64 bit long length}{0x0b0}{0x0b4}{R}{}
+  \hline
+  \mmiodreg{SHMBaseLow}{SHMBaseHigh}{Shared memory region 64 bit long physical address}{0x0b8}{0x0bc}{R}{}
+  \hline
+  \mmioreg{ConfigGeneration}{Configuration atomicity value}{0x0fc}{R}{}
+  \hline
+  \mmioreg{Config}{Configuration space}{0x100+}{RW}{}
+  \hline
+\end{longtable}
+
+The device sends a used buffer notification or a configuration change notification
+by a single, deditcated interrupt, which is differed by the bit described in the description of InterruptStatus. That is, after receiving an interrupt, driver uses InterruptStatus to differ the event source and uses InterruptACK register to acknowledge after handling.
+
+The notification mechanism is described in the QueueNotify register.
+
+\subsubsection{Version 1}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Version 1}
+The MMIO transport of version 1 used page-based addressing, resulting
 in a slightly different control register layout, the device
-initialization and the virtual queue configuration procedure.
+initialization and the virtual queue configuration procedure from later versions.
 
-Table \ref{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Legacy Register Layout} 
+Table \ref{tab:Virtio Trasport Options / Virtio Over MMIO / Version 1 MMIO Device Register Layout}
 presents control registers layout, omitting
 descriptions of registers which did not change their function
 nor behaviour:
 
 \begin{longtable}{p{0.2\textwidth}p{0.7\textwidth}}
-  \caption {MMIO Device Legacy Register Layout}
-  \label{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Legacy Register Layout} \\
+  \caption {Version 1 MMIO Device Register Layout}
+  \label{tab:Virtio Trasport Options / Virtio Over MMIO / Version 1 MMIO Device Register Layout} \\
   \hline
   \mmioreg{Name}{Function}{Offset from base}{Direction}{Description} 
   \hline 
@@ -2193,7 +2304,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
    the \field{QueuePFN} register.
 \end{enumerate}
 
-Notification mechanisms did not change.
+Notification mechanisms are the same as version 2.
 
 \section{Virtio Over Channel I/O}\label{sec:Virtio Transport Options / Virtio Over Channel I/O}
 
-- 
2.7.4

